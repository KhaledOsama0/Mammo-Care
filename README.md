<div align="center">

# Mammo Care

**A cross-platform Flutter application for breast-health care, backed by Supabase.**

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?logo=supabase&logoColor=white)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-informational)
![Status](https://img.shields.io/badge/Status-Early%20development-orange)

</div>

---

## Table of Contents

- [About](#about)
- [Project Status](#project-status)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [Author](#author)

---

## About

Mammo Care is a mobile and web application built with **Flutter** that uses **Supabase** as its backend for data and authentication. A single Dart codebase targets Android, iOS and the web.

> The project is under active development. This README describes what exists in the repository today and is updated as features land.

## Project Status

The repository currently contains the application foundation:

| Area | State |
| --- | --- |
| Flutter project (Android, iOS, Web) | Initialized |
| Supabase client (`supabase_flutter`) | Integrated |
| Environment-based configuration | Implemented via `--dart-define` |
| Product features and UI | In progress |

## Tech Stack

| Layer | Technology |
| --- | --- |
| Framework | [Flutter](https://flutter.dev) (Material Design) |
| Language | [Dart](https://dart.dev) `^3.13.7` |
| Backend | [Supabase](https://supabase.com) via [`supabase_flutter`](https://pub.dev/packages/supabase_flutter) `^2.18.3` |
| Linting | [`flutter_lints`](https://pub.dev/packages/flutter_lints) `^6.0.0` |

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) with a Dart SDK compatible with `^3.13.7`
- A [Supabase](https://supabase.com) project (you will need its URL and publishable key)
- For mobile targets: Android Studio / Android SDK, and Xcode (macOS only) for iOS

Verify your setup:

```bash
flutter doctor
```

### Installation

```bash
git clone https://github.com/KhaledOsama0/Mammo-Care.git
cd Mammo-Care
flutter pub get
```

### Configuration

Supabase credentials are **not** hard-coded. They are read at build time through Dart compile-time environment variables:

| Variable | Description |
| --- | --- |
| `SUPABASE_URL` | Your Supabase project URL |
| `SUPABASE_PUBLISHABLE_KEY` | Your Supabase publishable (anon) key |

You can find both values in your Supabase dashboard under **Project Settings → API**.

**Option 1: pass the values on the command line**

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://<your-project>.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=<your-publishable-key>
```

**Option 2: keep them in a local JSON file**

Create `.env.json` in the project root:

```json
{
  "SUPABASE_URL": "https://<your-project>.supabase.co",
  "SUPABASE_PUBLISHABLE_KEY": "<your-publishable-key>"
}
```

Then run:

```bash
flutter run --dart-define-from-file=.env.json
```

`.env` and `.env.*` files are listed in `.gitignore`, so your local credentials stay out of version control.

> **Security note:** only ever use the *publishable* key in the client app. Never embed a Supabase `service_role` / secret key in a Flutter build.

### Running the App

```bash
# List available devices
flutter devices

# Run on a specific device (append the --dart-define flags from above)
flutter run -d <device-id>

# Run in the browser
flutter run -d chrome
```

Static analysis and tests:

```bash
flutter analyze
flutter test
```

## Project Structure

```
Mammo-Care/
├── lib/
│   ├── main.dart                     # App entry point, Supabase initialization
│   └── core/
│       └── config/
│           └── supabase_config.dart  # Supabase URL / key and initialization
├── android/                          # Android platform project
├── ios/                              # iOS platform project
├── web/                              # Web platform project
├── pubspec.yaml                      # Dependencies and project metadata
└── analysis_options.yaml             # Lint rules
```

## Roadmap

- [x] Initialize Flutter project for Android, iOS and Web
- [x] Integrate Supabase client
- [x] Externalize backend configuration via `--dart-define`
- [ ] Replace the placeholder home screen with the real app UI
- [ ] Replace the default `com.example.*` application identifiers before release
- [ ] Add product features (tracked here as they are planned)

## Contributing

Contributions, issues and suggestions are welcome.

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "feat: add your feature"`
4. Push the branch: `git push origin feature/your-feature`
5. Open a Pull Request

Please run `flutter analyze` and `flutter test` before submitting.

## Author

**Khaled Osama** — [@KhaledOsama0](https://github.com/KhaledOsama0)