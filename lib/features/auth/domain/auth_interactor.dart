import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/features/auth/domain/repository/auth_local_repository.dart';
import 'package:notes_app/features/auth/domain/repository/auth_remote_repository.dart';

class AuthInteractor {
  final AuthRemoteRepository _remoteRepository;
  final AuthLocalRepository _localRepository;

  AuthInteractor({
    required AuthRemoteRepository remoteRepository,
    required AuthLocalRepository localRepository,
  })  : _remoteRepository = remoteRepository,
        _localRepository = localRepository;

  Stream<User?> observeRemoteUser() {
    return _remoteRepository.observeAuthState();
  }

  Stream<User?> observeLocalUser() {
    return _localRepository.userStream;
  }

  User? getUser() {
    return _localRepository.getUser();
  }

  void saveUser(User user) {
    _localRepository.saveUser(user);
  }

  Future<OAuthCredential> getGoogleCredential() {
    return _remoteRepository.getGoogleCredential();
  }

  Future<OAuthCredential> getAppleCredential() {
    return _remoteRepository.getAppleCredential();
  }

  Future<UserCredential> signInWithCredential(OAuthCredential credential) {
    return _remoteRepository.signInWithCredential(credential);
  }


  Future logOut() async {
    _localRepository.logOut();
    return _remoteRepository.logOut();
  }

  Future<UserCredential?> registerUser(String email, String password) {
    return _remoteRepository.registerUser(email, password);
  }

  Future<UserCredential?> signInWith({required String email, required String password}) {
    return _remoteRepository.signInWith(email: email, password: password);
  }

}
