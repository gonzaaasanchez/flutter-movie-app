import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;
  static const _sessionIdKey = 'sessionId';

  AuthenticationRepositoryImpl(
    this._secureStorage,
  );

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
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    if (username != 'test') {
      return Either.left(SignInFailure.notFound);
    }
    if (password != '123456') {
      return Either.left(SignInFailure.unauthorized);
    }
    await _secureStorage.write(key: _sessionIdKey, value: 'session');
    return Either.right(User());
  }
}
