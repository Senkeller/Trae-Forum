# Trae Forum

[![Flutter Version](https://img.shields.io/badge/Flutter-3.10+-blue.svg)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A Flutter client for Trae official community, integrating with the Discourse forum system (forum.trae.cn), providing complete topic browsing, search, and user interaction features.

[中文文档](README.md) | English

## Features

- **Topic Browsing**: Latest topics, hot topics, categorized topic lists
- **Topic Details**: Rich text rendering, image preview, table of contents navigation
- **Search Functionality**: Full-text search with category filtering and advanced search
- **User System**: User profiles, activity history, following/followers lists
- **Notifications**: Notification list, mark as read
- **WebView Login**: Integration with Trae main site SSO login system
- **Local Storage**: Browsing history, local favorites, drafts

## Tech Stack

| Category | Technology | Description |
|----------|------------|-------------|
| State Management | `flutter_riverpod` | Reactive state management with code generation support |
| Network | `dio` + `dio_cookie_manager` | Powerful HTTP client with Cookie persistence |
| Local Storage | `hive_ce` + `shared_preferences` | High-performance NoSQL database + KV storage |
| Routing | `go_router` | Declarative routing with deep linking support |
| Data Models | `freezed` + `json_serializable` | Immutable data classes with auto-generated serialization |
| Image Loading | `cached_network_image` | Network image loading with caching |
| Rich Text | `flutter_html` | HTML content rendering |
| WebView | `webview_flutter` | Native WebView embedding |

## Project Structure

```
lib/
├── main.dart                    # Application entry point
├── app.dart                     # Application configuration
├── config/
│   ├── constants.dart           # Application constants, API configuration
│   ├── routes.dart              # Route configuration
│   └── theme.dart               # Theme configuration
├── core/
│   ├── network/                 # Network layer
│   │   ├── dio_client.dart      # Dio client configuration
│   │   ├── discourse_api_service.dart  # Discourse API wrapper
│   │   ├── trae_dashboard_api.dart     # Trae dashboard API
│   │   └── interceptors/        # Interceptors
│   ├── services/                # Core services
│   └── utils/                   # Utilities
├── data/
│   ├── models/                  # Data models
│   ├── repositories/            # Data repositories
│   └── adapters/                # Data adapters
└── presentation/
    ├── pages/                   # Pages
    ├── widgets/                 # Widgets
    └── providers/               # State providers
```

## Login Flow

Trae Forum adopts **SSO (Single Sign-On)** architecture. The login flow is as follows:

```
┌─────────────────────────────────────────────────────────────────────┐
│                           Login Flow                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐      │
│  │  Trae Forum  │      │ www.trae.cn  │      │ forum.trae.cn│      │
│  │   (App)      │      │  (SSO Login) │      │  (Forum API) │      │
│  └──────┬───────┘      └──────┬───────┘      └──────┬───────┘      │
│         │                     │                     │              │
│         │  1. Open WebView    │                     │              │
│         │────────────────────▶│                     │              │
│         │   Load login page   │                     │              │
│         │                     │                     │              │
│         │  2. User enters     │                     │              │
│         │     phone & code    │                     │              │
│         │────────────────────▶│                     │              │
│         │                     │                     │              │
│         │  3. Login callback  │                     │              │
│         │◀────────────────────│                     │              │
│         │   Get Cookie        │                     │              │
│         │                     │                     │              │
│         │  4. Sync Cookie     │                     │              │
│         │──────────────────────────────────────────▶│              │
│         │   to forum domain │                     │              │
│         │                     │                     │              │
│         │  5. Verify login    │                     │              │
│         │──────────────────────────────────────────▶│              │
│         │                     │                     │              │
│         │  6. Login success, go to home             │              │
│         │◀──────────────────────────────────────────│              │
│         │                     │                     │              │
└─────────┴─────────────────────┴─────────────────────┴──────────────┘
```

## Requirements

- **Flutter**: >= 3.10.0
- **Dart**: >= 3.0.0
- **Android**: minSdkVersion 21
- **iOS**: iOS 11.0+

## Build Commands

### Development

```bash
# Get dependencies
flutter pub get

# Generate code (Freezed, Riverpod, JSON serialization)
flutter pub run build_runner build --delete-conflicting-outputs

# Run application (debug mode)
flutter run

# Run on specific device
flutter run -d <device_id>
```

### Code Generation

The project uses code generation tools. Regenerate after modifying:

```bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate during development)
flutter pub run build_runner watch --delete-conflicting-outputs
```

Files to generate:
- `*.freezed.dart` - Freezed data classes
- `*.g.dart` - JSON serialization and Riverpod Provider

### Build Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/pages/login_page_test.dart

# Run integration tests
flutter test integration_test/app_test.dart
```

### Code Analysis

```bash
# Static analysis
flutter analyze

# Format code
dart format lib/
```

## Contributing

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Create a Pull Request

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for detailed contribution guidelines.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Discourse API Documentation](https://docs.discourse.org/)
- [Trae Official Community](https://forum.trae.cn)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Note**: This is a community open-source project and is not officially affiliated with Trae.
