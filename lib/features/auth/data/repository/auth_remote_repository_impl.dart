import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/features/auth/data/service/firebase_auth_service.dart';
import 'package:notes_app/features/auth/domain/repository/auth_remote_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRemoteRepositoryImpl implements AuthRemoteRepository {
  final FirebaseAuthService _authService;

  AuthRemoteRepositoryImpl({
    required FirebaseAuthService authService,
  }) : _authService = authService;

  @override
  Stream<User?> observeAuthState() {
    return _authService.observeAuthState();
  }

  @override
  Future<UserCredential> signInWithCredential(OAuthCredential credential) async {
      // Once signed in, return the UserCredential
      return _authService.signInWithCredential(credential);
    }

  @override
  Future<OAuthCredential> getGoogleCredential() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return credential;
  }

  @override
  Future<OAuthCredential> getAppleCredential() async {

    final rawNonce = generateNonce();
    final nonce = _getSha256ofString(rawNonce);

    print('rawNonce: $rawNonce');
    print('nonce: $nonce');

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    print('appleCredential: $appleCredential');

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    print(oauthCredential);

    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)

    return oauthCredential;
  }

  @override
  Future<void> logOut() {
    return _authService.logout();
  }

  @override
  Future<UserCredential?> registerUser(String email, String password) {
    return _authService.registerUser(email, password);
  }

  @override
  Future<UserCredential?> signInWith({required String email, required String password}) {
    return _authService.signInWith(email: email, password: password);
  }

    /// Returns the sha256 hash of [input] in hex notation.
    String _getSha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }
}
