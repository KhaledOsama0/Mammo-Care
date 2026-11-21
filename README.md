<div align="center">

# Mammo Care

**An AI-powered mobile application for breast imaging analysis and patient-centered assessment reporting.**

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?logo=supabase&logoColor=white)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-informational)
![Status](https://img.shields.io/badge/Status-Under%20development-orange)

</div>

> [!WARNING]
> **Disclaimer:** Mammo Care is an academic project. Its AI-generated results are intended for informational and research purposes only and are **not** a substitute for professional medical evaluation or diagnosis.

---

## Table of Contents

- [About the Project](#about-the-project)
- [Core Features](#core-features)
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

## About the Project

Mammo Care is a graduation project that leverages Artificial Intelligence (AI) to support the breast imaging assessment process through an accessible, user-friendly mobile application.

Patients can upload their breast imaging scans for AI-powered analysis. The AI model processes the submitted images and generates assessment results, which are delivered back to the application and presented in a structured, easy-to-understand format.

By combining medical image submission, automated image analysis and result visualization in a single platform, Mammo Care simplifies access to breast imaging assessment information and gives patients a convenient way to review and track their results.

The initial development phase focuses on the **patient experience**: account management, medical image submission, AI analysis and assessment result tracking.

## Core Features

| Feature | Description |
| --- | --- |
| **User Authentication** | Create a patient account, sign in securely, and recover access through password reset. |
| **Medical Image Upload** | Select breast imaging scans from the device and upload them for AI analysis. |
| **AI-Powered Image Analysis** | Submit uploaded scans to the integrated AI model and receive the generated analysis output. |
| **Assessment Results** | View the analysis outcome and its associated assessment details in a structured results interface. |
| **Analysis History** | Browse previously submitted scans and review their corresponding results. |
| **Patient Profile** | View and update personal account information. |

> These features define the scope of the initial phase and are being implemented. See [Project Status](#project-status) for what is in the repository today.

## Project Status

**Under development.** The repository currently contains the application foundation:

| Area | State |
| --- | --- |
| Flutter project (Android, iOS, Web) | Initialized |
| Supabase client (`supabase_flutter`) | Integrated |
| Environment-based configuration | Implemented via `--dart-define` |
| Core features listed above | In progress |

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
- [ ] User authentication (sign up, sign in, password reset)
- [ ] Medical image upload
- [ ] AI-powered image analysis integration
- [ ] Assessment results screen
- [ ] Analysis history
- [ ] Patient profile management
- [ ] Replace the default `com.example.*` application identifiers before release

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

---

<div align="center">

**Mammo Care** — Advancing accessible breast imaging assessment through AI.

</div>
