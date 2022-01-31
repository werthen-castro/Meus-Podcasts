import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_client.dart';
import 'auth_response.dart';

class AuthClientImpl implements AuthClient {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return AuthResponse(data: user.user, sucess: true);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(
        statusCode: e.code,
        statusMessage: e.message,
      );
    }
  }

  @override
  Future<AuthResponse> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return AuthResponse(data: user.user, sucess: true);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(statusCode: e.code, statusMessage: e.message);
    }
  }

  @override
  Future<AuthResponse> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential user = await _auth.signInWithCredential(credential);
      return AuthResponse(data: user.user, sucess: true);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(statusCode: e.code, statusMessage: e.message);
    }
  }

  @override
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
