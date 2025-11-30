import 'dart:developer';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    currentUser.value = _supabase.auth.currentUser;

    _supabase.auth.onAuthStateChange.listen((data) {
      currentUser.value = data.session?.user;
      log('Auth state changed: ${data.session?.user?.email ?? "No user"}');
    });
  }

  Future<UserModel?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      log('Attempting signup for: $email');

      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null,
      );

      log('Signup response - User: ${response.user?.email}, Session: ${response.session != null}');

      if (response.user != null && response.session == null) {
        log('User created but no session - email confirmation may be required');

        throw Exception(
            'Please check your email to confirm your account before logging in.');
      }

      if (response.user != null) {
        return UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          createdAt: response.user!.createdAt,
        );
      }

      return null;
    } on AuthException catch (e) {
      log('Signup AuthException: ${e.message}, Code: ${e.statusCode}');

      if (e.message.toLowerCase().contains('already registered') ||
          e.message.toLowerCase().contains('already been registered')) {
        throw Exception(
            'This email is already registered. Please login instead.');
      }

      if (e.message.toLowerCase().contains('invalid email')) {
        throw Exception('Invalid email format. Please check and try again.');
      }

      if (e.message.toLowerCase().contains('password')) {
        throw Exception('Password must be at least 6 characters long.');
      }

      throw Exception(e.message);
    } catch (e) {
      log('Signup error: $e');

      if (e is Exception) {
        rethrow;
      }

      throw Exception('Signup failed. Please try again.');
    }
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      log('Attempting signin for: $email');

      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      log('Signin response - User: ${response.user?.email}, Session: ${response.session != null}');

      if (response.user != null && response.session != null) {
        return UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          createdAt: response.user!.createdAt,
        );
      }

      if (response.user != null && response.session == null) {
        throw Exception('Please confirm your email before logging in.');
      }

      return null;
    } on AuthException catch (e) {
      log('Signin AuthException: ${e.message}, Code: ${e.statusCode}');

      if (e.message.toLowerCase().contains('invalid login credentials') ||
          e.message.toLowerCase().contains('invalid email or password')) {
        throw Exception('Invalid email or password. Please try again.');
      }

      if (e.message.toLowerCase().contains('email not confirmed')) {
        throw Exception(
            'Please confirm your email before logging in. Check your inbox.');
      }

      if (e.message.toLowerCase().contains('user not found')) {
        throw Exception(
            'No account found with this email. Please sign up first.');
      }

      if (e.statusCode == '400') {
        throw Exception(
            'Invalid email or password. Please check your credentials.');
      }

      throw Exception(e.message);
    } catch (e) {
      log('Signin error: $e');

      if (e is Exception) {
        rethrow;
      }

      throw Exception('Login failed. Please try again.');
    }
  }

  Future<void> signOut() async {
    try {
      log('Signing out user');
      await _supabase.auth.signOut();
      log('Signout successful');
    } on AuthException catch (e) {
      log('Signout error: ${e.message}');
      throw Exception('Failed to logout: ${e.message}');
    } catch (e) {
      log('Signout error: $e');
      throw Exception('Failed to logout. Please try again.');
    }
  }

  bool isLoggedIn() {
    final user = _supabase.auth.currentUser;
    final isLoggedIn = user != null;
    log('isLoggedIn check: $isLoggedIn (${user?.email ?? "no email"})');
    return isLoggedIn;
  }

  String? getCurrentUserEmail() {
    return _supabase.auth.currentUser?.email;
  }

  String? getCurrentUserId() {
    return _supabase.auth.currentUser?.id;
  }

  UserModel? getCurrentUserModel() {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    return UserModel(
      id: user.id,
      email: user.email!,
      createdAt: user.createdAt,
    );
  }

  bool isEmailConfirmed() {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    return _supabase.auth.currentSession != null;
  }

  Future<void> resendConfirmationEmail(String email) async {
    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      log('Confirmation email resent to: $email');
    } on AuthException catch (e) {
      log('Resend confirmation error: ${e.message}');
      throw Exception('Failed to resend confirmation email: ${e.message}');
    }
  }
}
