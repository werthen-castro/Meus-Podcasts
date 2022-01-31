import 'auth_response.dart';

abstract class AuthClient {
  Future<AuthResponse> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<AuthResponse> createUserWithEmailAndPassword(
      {required String email, required String password});

  Future<AuthResponse> signInwithGoogle();

  Future<void> signOutFromGoogle();
}
