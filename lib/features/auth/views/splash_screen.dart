import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    print('SplashScreen: Starting initialization');

    // Add a small delay for splash screen effect
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      final authViewModel = context.read<AuthViewModel>();
      print('SplashScreen: Calling initializeAuth');
      await authViewModel.initializeAuth();
      print('SplashScreen: initializeAuth completed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Icon(Icons.business, size: 100, color: Colors.white),
            SizedBox(height: 24),

            // App Name
            Text(
              'Employee Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),

            Text(
              'SUPERVIP',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 48),

            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 16),

            Text(
              'Loading...',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
