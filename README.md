# Delivery App

A Flutter application for delivery management with Firebase authentication and QR code scanning capabilities.

## Features

- **Login Screen**: Mobile number input with OTP-based authentication
- **OTP Verification**: 6-digit OTP verification using Firebase Authentication
- **Dashboard**: Main navigation hub
- **Delivery List**: View and manage deliveries from Firestore
- **QR Code Scanner**: Scan QR codes for delivery tracking

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Firebase project
- Android Studio / VS Code with Flutter extensions

### Firebase Configuration

#### Option 1: Using FlutterFire CLI (Recommended)

1. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Configure Firebase for your project:
```bash
flutterfire configure
```

This will:
- Generate `lib/firebase_options.dart`
- Configure Firebase for Android and iOS platforms
- Set up necessary configuration files

#### Option 2: Manual Configuration

1. **Android Setup:**
   - Download `google-services.json` from Firebase Console
   - Place it in `android/app/` directory
   - Update `android/build.gradle` and `android/app/build.gradle` as per Firebase documentation

2. **iOS Setup:**
   - Download `GoogleService-Info.plist` from Firebase Console
   - Place it in `ios/Runner/` directory
   - Update `ios/Runner/Info.plist` as needed

3. **Firebase Options:**
   - Create `lib/firebase_options.dart` manually or use FlutterFire CLI

### Firebase Console Setup

1. **Enable Phone Authentication:**
   - Go to Firebase Console → Authentication → Sign-in method
   - Enable "Phone" provider
   - **For Testing (Recommended with Spark Plan):**
     - Click on "Phone numbers for testing"
     - Add test phone numbers (e.g., +911234567890)
     - Set a test OTP code (e.g., "123456")
     - **Important:** Test numbers don't count against the 10/day limit and don't send real SMS
     - The app code works the same way - just use the test OTP code you configured

2. **Create Firestore Database:**
   - Go to Firebase Console → Firestore Database
   - Create a database in test mode (or production with proper rules)
   - Create a collection named `deliveries`
   - **Manually add delivery documents** with the following structure:
     ```json
     {
       "orderId": "#INV-2024-1236",
       "customerName": "Dominic John",
       "numberOfBoxes": 5,
       "status": "Out of delivery",
       "deliveryAddress": "Downtown Miami, Biscayne Blvd, Miami, FL.",
       "dateTime": "2024-11-10T09:30:00Z",
       "paymentMethod": "COD"
     }
     ```
   - The app will automatically fetch and display these deliveries

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd delivery_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── constants/       # App-wide constants
│   ├── di/              # Dependency injection
│   ├── error/           # Error handling
│   ├── theme/           # App theme
│   ├── utils/           # Utility functions
│   └── widgets/         # Reusable widgets
├── features/
│   ├── auth/            # Authentication feature
│   │   ├── data/        # Data layer (models, repositories, datasources)
│   │   ├── domain/      # Domain layer (entities, repositories)
│   │   └── presentation/ # Presentation layer (pages, providers)
│   ├── dashboard/       # Dashboard feature
│   ├── delivery_list/   # Delivery list feature
│   └── qr_scanner/      # QR scanner feature
└── main.dart            # App entry point
```

## Architecture

This project follows **Clean Architecture** principles with **Provider** for state management:

- **Domain Layer**: Pure business logic, no dependencies
- **Data Layer**: Handles data sources (Firebase), implements domain repositories
- **Presentation Layer**: UI components and state management with Provider

## State Management

The app uses **Provider** for state management, providing:
- Separation of UI and business logic
- Reactive state updates
- Easy testing and maintenance

## Assumptions

1. Phone numbers are formatted with country code (+91 for India by default)
2. OTP length is 6 digits
3. Firestore collection name is `deliveries`
4. Delivery status values: "pending", "in-progress", "delivered", "cancelled"

## Testing

To run tests:
```bash
flutter test
```

## Build

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

## Troubleshooting

### Firebase Not Initialized
- Make sure you've run `flutterfire configure` or manually configured Firebase
- Check that `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location

### OTP Not Received
- Verify phone authentication is enabled in Firebase Console
- Check that test phone numbers are added (for development)
- Ensure proper phone number formatting with country code

### Firestore Permission Errors
- Check Firestore security rules in Firebase Console
- For development, you can use test mode (not recommended for production)

## License

This project is created for assessment purposes.
