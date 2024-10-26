# Xpanse - Mobile Money Expense Tracker

<div align="center">
  
![Xpanse Logo](placeholder-for-logo.png)

*Your Personal Finance Companion*

</div>

## 📱 About Xpanse

Xpanse is an innovative mobile expense tracking application designed to revolutionize personal finance management in the digital age. Our mission is to democratize access to sophisticated financial management tools while promoting financial literacy and empowering individuals to take control of their economic lives.

## ✨ Key Features

### Real-time Expense Tracking
- Immediate transaction recording
- Automated expense categorization
- Integration with mobile money services

### Intuitive Dashboard
- Interactive spending graphs
- Category-wise expense breakdown
- Budget status monitoring
- Recent transactions list

### Smart Budgeting Tools
- Customizable budget categories
- Real-time alerts
- Spending pattern analysis
- Financial insights generation

## 🛠️ Technical Stack

- **Framework**: Flutter SDK
- **Language**: Dart
- **State Management**: GetX
- **Database**: SQLite
- **Charts**: fl_chart
- **Local Storage**: shared_preferences
- **Authentication**: firebase_auth
- **Secure Storage**: flutter_secure_storage

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Git
- A physical device or emulator for testing

## ⚙️ Installation

1. Clone the repository:
```bash
git clone https://github.com/Adisa-Shobi/Xpanse.git
cd Xpanse
```

2. Get Flutter dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release
```

## 📱 Code Examples

### Route Management (lib/routes/app_pages.dart)
```dart
import 'package:get/get.dart';
import '../views/screens.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    // Add other routes...
  ];
}
```

### Route Names (lib/routes/route_names.dart)
```dart
abstract class RouteNames {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  // Add other route names...
}
```

### Theme Configuration (lib/utils/theme.dart)
```dart
import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTypography.textTheme,
      // Add other theme configurations...
    );
  }
}
```

## 📁 Project Structure

```
xpanse_app/
├── lib/
│   ├── main.dart               # App entry point
│   ├── bindings/               # GetX dependency injection
│   ├── controllers/            # GetX controllers
│   ├── routes/                 # Route management
│   │   ├── app_pages.dart      # GetX page definitions
│   │   └── route_names.dart    # Route name constants
│   ├── utils/                  # Utility functions
│   │   ├── colors.dart         # Color constants
│   │   ├── responsive.dart     # Responsive design utilities
│   │   ├── spacing.dart        # Spacing constants
│   │   ├── theme.dart          # App theme configuration
│   │   └── typography.dart     # Text styles
│   └── views/                  # UI screens
├── android/                    # Android specific files
├── ios/                        # iOS specific files
├── linux/                      # Linux specific files
├── macos/                     # macOS specific files
├── web/                       # Web specific files
├── windows/                   # Windows specific files
├── .gitignore                 # Git ignore file
├── .metadata                  # Flutter metadata
├── analysis_options.yaml      # Dart analysis options
└── pubspec.yaml               # Project dependencies
```

### Key Directories Explained

#### `lib/`
- **main.dart**: Application entry point, initializes GetX and theme
- **bindings/**: Contains GetX dependency injection setup
- **controllers/**: GetX controllers for state and business logic
- **routes/**: Navigation and routing configuration
- **utils/**: Helper functions, constants, and configurations
- **views/**: All UI screens and reusable widgets

## 🔧 Common Issues & Solutions

1. **Build Issues**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. **IDE Integration**
   - Install Flutter and Dart plugins
   - Set Flutter SDK path correctly
   - Run `flutter doctor`

3. **GetX State Management**
   - Use `.obs` for observable variables
   - Implement `GetxController` for state management
   - Use `Get.put()` or `Get.lazyPut()` for dependency injection

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 👥 Development Team

- Shobi Gboluwaga Ola-Adisa - Lead Developer
- Miracle Glen Bonyu
- Ademola Emmanuel Oshingbesan
- Jordan Steve Lopez Nguepi
- Ronald Aderinsola Abimbola
- Michael George

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support or queries:
- Email: s.olaadisa@alustudent.com
- GitHub Issues: [Xpanse Issues](https://github.com/Adisa-Shobi/Xpanse/issues)

## 🙏 Acknowledgments

- Flutter Team and Community
- Our contributors and beta testers
- GetX library maintainers

---

*Built with ❤️ by the Xpanse Team*