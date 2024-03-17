import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/remote/authentication_api.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._authenticationApi,
    this._secureStorage,
  );
  final AuthenticationApi _authenticationApi;
  final FlutterSecureStorage _secureStorage;
  static const _sessionIdKey = 'sessionId';

  @override
  Future<bool> get isLogged async {
    final sessionID = await _secureStorage.read(key: _sessionIdKey);
    return sessionID != null;
  }

  @override
  Future<User?> getUserData() {
    return Future.value(
      User(),
    );
  }

  @override
  Future<void> signOut() {
    return _secureStorage.delete(key: _sessionIdKey);
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  ) async {
    final requestTokenResult = await _authenticationApi.createRequestToken();
    return requestTokenResult.when(
      (failure) => Either.left(failure),
      (requestToken) async {
        final loginResult = await _authenticationApi.createSessionWithLogin(
          username: username,
          password: password,
          requestToken: requestToken,
        );

        return loginResult.when(
          (failure) async {
            return Either.left(failure);
          },
          (newRequestToken) async {
            final sessionResult = await _authenticationApi.createSession(
              newRequestToken,
            );
            return sessionResult.when((failure) async {
              return Either.left(failure);
            }, (sessionId) async {
              await _secureStorage.write(
                key: _sessionIdKey,
                value: sessionId,
              );
              return Either.right(
                User(),
              );
            });
          },
        );
      },
    );
  }
}
