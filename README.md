# GymTrack demo version 

GymTrack is a Flutter workout-tracking app for planning training, following
fitness goals, and reviewing workout progress. It runs on Android, iOS, and the
web.  the web app appears in a responsive,
interactive phone preview; on smaller screens, it fills the viewport.

## Features

- Home dashboard with workout summaries, daily motivation, and a workout calendar
- Browse workout programs by category, or search for a program
- Create and explore workout plans and exercises
- Track active and completed fitness goals
- Review workout history and progress
- English and French language options
- Responsive web layout with a live mobile preview on wider screens

Some screens currently use sample in-app data. The app does not currently
provide account-based or cloud synchronization.

## Screenshots
<img width="%100" alt="9bb4483a-0a11-4ede-bb55-89b954a77e5d" src="https://github.com/user-attachments/assets/0c8acee0-6c81-4323-87f3-fec1fb428d24" />


## Getting started

### Requirements

- Flutter SDK 3.47.6 (stable) or a compatible version
- Dart SDK 3.9 or later
- Android Studio/Xcode for the respective mobile targets

### Install dependencies

```sh
flutter pub get
```

### Run the app

Run in Chrome:

```sh
flutter run -d chrome
```

Run on a connected device or simulator:

```sh
flutter devices
flutter run -d <device-id>
```

### Build

Create a production web build:

```sh
flutter build web --release
```

The generated site is written to `build/web`.

Build Android or iOS using Flutter's standard commands:

```sh
flutter build apk
flutter build ios
```

## Deploy to Vercel

Import the repository into Vercel and deploy using the included `vercel.json`.
Vercel runs `scripts/vercel-build.sh`, which downloads Flutter 3.47.6 on the
first build, creates a release web build, and publishes `build/web`. The first
deployment may take longer while the Flutter SDK is downloaded.

To select another stable Flutter SDK version, set the `FLUTTER_VERSION`
environment variable in the Vercel project settings. The corresponding Linux
Flutter SDK archive must be available.

## Project structure

```text
lib/
  core/       Shared colors, fonts, and language strings
  providers/  App state providers
  screens/    App screens
  services/   App services
  widgets/    Reusable UI components
assets/       App images and other assets
android/      Android project
ios/          iOS project
web/          Web entry point, icons, and manifest
```

## Built with

- [Flutter](https://flutter.dev/)
- [Provider](https://pub.dev/packages/provider) for app state
- [Shared Preferences](https://pub.dev/packages/shared_preferences) for local
  language preference

## Contributing

Issues and pull requests are welcome. For significant changes, open an issue
first to discuss the proposed change.

