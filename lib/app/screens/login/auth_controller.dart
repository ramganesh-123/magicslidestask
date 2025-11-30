import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicslides_app/app/core/config/app_config.dart';
import 'package:magicslides_app/app/data/models/user_model.dart';
import 'package:magicslides_app/app/data/services/auth_services.dart';
import 'package:magicslides_app/app/data/services/user_services.dart';
import 'package:magicslides_app/app/routes/app_router.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final StorageService _storageService = Get.find<StorageService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxString pendingConfirmationEmail = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> checkAuthStatus() async {
    if (_authService.isLoggedIn()) {
      currentUser.value = _authService.getCurrentUserModel();
      Get.offAllNamed(AppRoutes.home);
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return AppStrings.weakPassword;
    }
    return null;
  }

  Future<void> signUp() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        AppStrings.invalidEmail,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        AppStrings.weakPassword,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final user = await _authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (user != null) {
        await _storageService.saveUserEmail(user.email);
        currentUser.value = user;

        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        emailController.clear();
        passwordController.clear();
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '').trim();

      if (errorMessage.contains('check your email') ||
          errorMessage.contains('confirm your account')) {
        pendingConfirmationEmail.value = emailController.text.trim();

        Get.dialog(
          AlertDialog(
            title: const Text('Email Confirmation Required'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We\'ve sent a confirmation email to:',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Text(
                  emailController.text.trim(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Please check your inbox and click the confirmation link before logging in.',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Get.back();
                  await resendConfirmationEmail();
                },
                child: const Text('Resend Email'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      } else if (errorMessage.contains('already registered')) {
        Get.snackbar(
          'Email Already Registered',
          'This email is already registered. Please login instead.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );

        Future.delayed(const Duration(seconds: 4), () {
          if (Get.currentRoute != AppRoutes.login) {
            Get.back();
          }
        });
      } else {
        Get.snackbar(
          'Sign Up Failed',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final user = await _authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (user != null) {
        await _storageService.saveUserEmail(user.email);
        currentUser.value = user;

        Get.snackbar(
          'Success',
          'Logged in successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        emailController.clear();
        passwordController.clear();
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '').trim();

      if (errorMessage.contains('confirm your email') ||
          errorMessage.contains('email not confirmed')) {
        pendingConfirmationEmail.value = emailController.text.trim();

        Get.dialog(
          AlertDialog(
            title: const Text('Email Not Confirmed'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please confirm your email address before logging in. Check your inbox for the confirmation link.',
                ),
                SizedBox(height: 16),
                Text(
                  'Didn\'t receive the email?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Get.back();
                  await resendConfirmationEmail();
                },
                child: const Text('Resend Email'),
              ),
            ],
          ),
        );
      } else {
        Get.snackbar(
          'Login Failed',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendConfirmationEmail() async {
    final email = pendingConfirmationEmail.value.isEmpty
        ? emailController.text.trim()
        : pendingConfirmationEmail.value;

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      await _authService.resendConfirmationEmail(email);

      Get.snackbar(
        'Email Sent',
        'Confirmation email has been resent. Please check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend confirmation email. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      await _storageService.clearUserData();
      currentUser.value = null;

      emailController.clear();
      passwordController.clear();

      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
