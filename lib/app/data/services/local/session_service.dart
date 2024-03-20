import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _sessionIdKey = 'sessionId';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId async {
    final sessionID = await _secureStorage.read(key: _sessionIdKey);
    return sessionID;
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: _sessionIdKey,
      value: sessionId,
    );
  }

  Future<void> signOut() {
    return _secureStorage.delete(key: _sessionIdKey);
  }
}
