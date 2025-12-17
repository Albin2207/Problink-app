import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check authentication state
    final user = FirebaseAuth.instance.currentUser;

    if (mounted) {
      if (user != null) {
        // User is logged in, navigate to dashboard
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } else {
        // User is not logged in, navigate to login
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Image
            Image.asset(
              'assets/images/splash_logo.png',
              width: 240,
              height: 260,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to icon if image not found
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.local_shipping,
                    size: 60,
                    color: AppColors.primaryBlue,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            // App Name

            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
