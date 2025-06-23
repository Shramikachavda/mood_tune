import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/get_it.dart';
import '../../database/local_db/secure_storage.dart';
import '../../model/user.dart';

class AuthService {
 // final storage = getIt<SecureStorage>();
  final storage = Get.find<SecureStorage>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Simulate Google login and return a real user
  Future<User?> googleSignInMethod() async {
    try {
      // Trigger the Google Sign-In flow
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If the user cancels the sign-in
      if (googleUser == null) {
        return null;
      }

      // Get authentication details
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a User object with the details from Google
      User user = User(
        name: googleUser.displayName ?? "Google User",
        email: googleUser.email,
        token:
            googleAuth.idToken ??
            "google-auth-token", // Here you can use the actual token
      );

      // Store the token in secure storage
      await storage.setData(key: "auth_token", value: user.token);

      return user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // Simulate Email/Password login and return a mock user
  Future<User?> emailSignInMethod(String email, String password) async {
    // Simulate a successful login if email and password match (for testing)
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay

    if (email == "user@example.com" && password == "password123") {
      User user = User(
        name: "Test User",
        email: email,
        token: "email-auth-token-7891011", // Simulated token
      );

      // Store the token in secure storage
      await storage.setData(key: "auth_token", value: user.token);

      return user;
    } else {
      // Invalid login
      return null;
    }
  }

  // Retrieve the stored user token
  Future<String?> getAuthToken() async {
    return await storage.getData(key: "auth_token");
  }

  // Log out the user by clearing the secure storage
  Future<void> logOut() async {
    await googleSignIn.signOut(); // Google Sign-Out
    await storage.deleteData(key: "auth_token"); // Clear secure storage
  }
}
