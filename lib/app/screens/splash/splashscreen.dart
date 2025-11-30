import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicslides_app/app/data/services/auth_services.dart';
import 'package:magicslides_app/app/routes/app_router.dart';
import 'package:magicslides_app/app/screens/login/auth_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Ensure AuthController is initialized
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }

    final authService = Get.find<AuthService>();

    // Add a small delay for splash screen effect
    await Future.delayed(const Duration(seconds: 2));

    if (authService.isLoggedIn()) {
      // User is logged in, go to home
      Get.offAllNamed(AppRoutes.home);
    } else {
      // User is not logged in, go to login
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.slideshow,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'MagicSlides',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Generate amazing presentations with AI',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
