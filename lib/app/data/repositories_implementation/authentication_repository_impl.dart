import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
