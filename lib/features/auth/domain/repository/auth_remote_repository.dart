import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteRepository {
  Stream<User?> observeAuthState();

  Future<OAuthCredential> getGoogleCredential();

  Future<OAuthCredential> getAppleCredential();

  Future<UserCredential> signInWithCredential(OAuthCredential credential);

  Future<void> logOut();

  Future<UserCredential?> registerUser(String email, String password);

  Future<UserCredential?> signInWith({required String email, required String password});
}
