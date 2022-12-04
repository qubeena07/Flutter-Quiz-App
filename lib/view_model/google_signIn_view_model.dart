// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  //sign in with google using firebase

  Future<User?> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        //  Navigator.pushReplacementNamed(
        //                 context, RoutesName.welcomeScreen);
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));

        return userCredential.user;
      }
    } else {
      throw FirebaseAuthException(
          code: "Error_aborder_by_user", message: "Sign In aborded by user");
    }
    return null;
  }

//signout with firebase
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
