import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _sessionIdKey = 'sessionId';
const _accountIdKey = 'accountId';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId async {
    return _secureStorage.read(key: _sessionIdKey);
  }

  Future<String?> get accountId {
    return _secureStorage.read(key: _accountIdKey);
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: _sessionIdKey,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) {
    return _secureStorage.write(
      key: _accountIdKey,
      value: accountId,
    );
  }

  Future<void> signOut() async {
    return _secureStorage.deleteAll();
  }
}
