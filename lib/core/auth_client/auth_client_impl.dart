import 'package:firebase_auth/firebase_auth.dart';

import 'auth_client.dart';
import 'auth_response.dart';

class AuthClientImpl implements AuthClient {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
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
  Future createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return AuthResponse(data: user.user, sucess: true);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(statusCode: e.code, statusMessage: e.message);
    }
  }
}
