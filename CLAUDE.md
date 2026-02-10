# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Run the app
flutter run

# Build for specific platforms
flutter build apk       # Android
flutter build ios       # iOS
flutter build web       # Web
flutter build windows   # Windows

# Get dependencies
flutter pub get

# Clean build artifacts
flutter clean
```

## Test Commands

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

## Lint Commands

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/ test/
```

## Architecture

This is currently a minimal Flutter starter project using the default counter demo. The codebase uses:

- **Material 3** design system with custom color scheme (deep purple seed)
- **Simple setState** pattern for state management
- **Single file structure** (`lib/main.dart` contains all code)

As the project grows, consider organizing into:
- `lib/models/` - Data models
- `lib/screens/` - Screen widgets
- `lib/widgets/` - Reusable components
- `lib/services/` - Business logic and API calls

## Key Dependencies

- **cupertino_icons** - iOS-style icons
- **flutter_lints** - Linting rules (configured in `analysis_options.yaml`)

## Platform Support

Android, iOS, Web, Windows, Linux, macOS
