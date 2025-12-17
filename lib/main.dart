import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'core/constants/app_colors.dart';
import 'core/di/service_locator.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_verification_page.dart';
import 'features/splash_screen.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/dashboard/presentation/page/dashboard_screen.dart';
import 'features/delivery/presentation/page/delivery_screen.dart';
import 'features/delivery/presentation/provider/delivery_provider.dart';
import 'features/qrcode/presentation/page/qr_code_screen.dart';
import 'features/qrcode/presentation/provider/qr_code_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Service Locator
  await serviceLocator.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(serviceLocator.authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => DeliveryProvider(serviceLocator.deliveryRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => QrCodeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Delivery App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryBlue,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: 'SF Pro',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryBlue,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/otp': (context) => const OtpVerificationPage(),
          '/dashboard': (context) => const DashboardPage(),
          '/delivery-list': (context) => const DeliveryListPage(),
          '/qr-scanner': (context) => const QrScannerPage(),
        },
      ),
    );
  }
}