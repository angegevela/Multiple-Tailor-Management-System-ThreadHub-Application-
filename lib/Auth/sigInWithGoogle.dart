import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// A service class to handle Google Sign-In
// and authentication using Firebase.
class GoogleAuthService {
  // FirebaseAuth instance to handle authentication.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GoogleSignIn instance to handle Google Sign-In.
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    serverClientId: "YOUR_WEB_CLIENT_ID.apps.googleusercontent.com",
  );

  /// Signs in the user with Google and returns the authenticated Firebase [User].
  /// Returns `null` if the sign-in process is canceled or fails.
  Future<User?> signInWithGoogle() async {

    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google sign in cancelled by user");
        return null;
      }

      final googleAuth = await googleUser.authentication;
      print("Access Token: ${googleAuth.accessToken}");
      print("ID Token: ${googleAuth.idToken}");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e, st) {
      print("Sign-in error: $e");
      print("Stack trace: $st");
      return null;
    }
  }

  /// Signs out the user from both Google and Firebase.
  Future<void> signOut() async {
    // Sign out from Google.
    await _googleSignIn.signOut();

    // Sign out from Firebase.
    await _auth.signOut();
  }
}
