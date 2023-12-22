import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../controllers/auth_controller.dart';
import '../../home_screen/home.dart';

class GSignInService {
  var controller = Get.put(AuthController());

  Future<void> signOut() async {
    try {
      // Sign out from Google
      await GoogleSignIn().signOut();

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger Google sign-in
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Check if user canceled the sign-in
      if (gUser == null) {
        return null;
      }

      // Obtain GoogleSignInAuthentication
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create Firebase credential with Google auth
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to Firebase with the obtained credential
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Retrieve user information
      User? user = authResult.user;

      // Print/display user's display name
      print('User Display Name: ${user?.displayName}');
      print('User Email: ${user?.email}');

      await controller.storeUserData(
          email: user?.email, password: '', name: user?.displayName);
      Get.offAll(() => const Home());

      return authResult;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }
}
