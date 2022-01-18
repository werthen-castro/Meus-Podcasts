abstract class AuthClient {
  Future signInWithEmailAndPassword(
      {required String email, required String password});

  Future createUserWithEmailAndPassword(
      {required String email, required String password});
}
