import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  // Sign in with Google method
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Sign in with Google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Store user data in Firestore
      if (userCredential.user != null) {
        await usersCollection.doc(userCredential.user!.email).set({
          'name': gUser.displayName,
          'bio': 'Add bio', // Default bio, you can customize this later
          'photo': gUser.photoUrl,
        });
      }

      return userCredential;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      // Sign out from Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Sign out from Google Sign-In
      await GoogleSignIn().signOut();
    } catch (error) {
      print("Error signing out: $error");
    }
  }
}
