# Xpanse - Mobile Money Expense Tracker

## 📱 About Xpanse

Xpanse is an innovative mobile expense tracking application designed to
revolutionize personal finance management in the digital age. Our mission is to
democratize access to sophisticated financial management tools while promoting
financial literacy and empowering individuals to take control of their economic
lives.

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
cd Xpanse/xpanse_app
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

## 💡 Usage Examples

### Quick Target setting
1. Tap '+' on home screen
2. Set/Edit your budget for that month
3. Save budget

### Monitor
1. Scroll through parsed transactions
2. See cash flow
3. Monitor spending

### Categorize
1. Create categories as needed
2. Assign transactions to categories when you press and hold
3. View your spending per category

### Reports & Analysis
View spending patterns through interactive charts and categorization.

### Settings & Security
Customize app preferences by setting start of week and start of month

## Authentication Methods Implemented

### Sign in with Google

Simple one-click authentication using Google accounts. Automatically handles
user profile info and profile pictures.

### Email & Password

Traditional email/password registration with email verification and password
reset functionality. Requires secure password with minimum requirements.

## Security Rules

```
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read and write their own documents
    match /users/{userId} {
      allow create: if request.auth != null;
      allow read, update: if request.auth != null && request.auth.uid == userId;
    }
    
    // Add rules for users_data collection
    match /users_data/{userId} {
      allow create: if request.auth != null;
      allow read, update: if request.auth != null && request.auth.uid == userId;
    }
    
    // Add rules for transactions collection
    match /transactions/{transactionId} {  
  		allow read: if request.auth != null && resource.data.userId == request.auth.uid;
  		allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
  		allow update: if request.auth != null && request.resource.data.userId == request.auth.uid;
		}
    
    // Add rules for categories collection
    match /categories/{categoryId} {  
  		allow read: if request.auth != null && resource.data.userId == request.auth.uid;
  		allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
  		allow update: if request.auth != null && request.resource.data.userId == request.auth.uid;
		}
  }
}
```

#### USERS COLLECTION

/users/{userId} Purpose: Store user profiles Rules:

- Create: Must be authenticated
- Read/Update: Only if document ID matches user's auth ID
- Delete: Not allowed

#### USERS_DATA COLLECTION

/users_data/{userId} Purpose: Additional user information Rules:
`Same as users collection`

#### TRANSACTIONS COLLECTION

/transactions/{transactionId} Purpose: Store financial transactions Rules:

- Read/Create/Update: Only if document's userId field matches auth ID
- Delete: Not allowed

#### CATEGORIES COLLECTION

/categories/{categoryId} Purpose: Transaction categories Rules: Same as
transactions collection

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

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.

## 📞 Support

For support or queries:

- Email: s.olaadisa@alustudent.com
- GitHub Issues: [Xpanse Issues](https://github.com/Adisa-Shobi/Xpanse/issues)

## 🙏 Acknowledgments

- Flutter Team and Community
- Our contributors and beta testers
- GetX library maintainers

---

_Built with ❤️ by the Xpanse Team_
