import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://jxjyihpsrhoglyocridk.supabase.co',
  );

  static const String publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_XJlBf3pL7KwJ85dMQX6r4Q_r4ppYZKp',
  );

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: publishableKey,
    );
  }
}
