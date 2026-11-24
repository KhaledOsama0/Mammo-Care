import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/supabase_config.dart';
import 'core/localization/locale_cubit.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'l10n/app_localizations.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Safely initialize Supabase if credentials are provided via dart-define
  try {
    if (SupabaseConfig.supabaseUrl.isNotEmpty &&
        SupabaseConfig.publishableKey.isNotEmpty) {
      await SupabaseConfig.initSupabase();
    }
  } catch (e) {
    debugPrint('Supabase initialization deferred: $e');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              final isArabic = locale.languageCode == 'ar';

              return MaterialApp.router(
                title: 'Mammo Care',
                debugShowCheckedModeBanner: false,
                scrollBehavior: const AppScrollBehavior(),
                routerConfig: AppRouter.router,
                theme: AppTheme.light(isArabic: isArabic),
                darkTheme: AppTheme.dark(isArabic: isArabic),
                themeMode: themeMode,
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
