import '../../../domain/models/user.dart';
import '../../http/http.dart';

class AccountApi {
  AccountApi(
    this._http,
  );

  final Http _http;

  Future<User?> getAccount(String sessionId) async {
    final result = await _http.request(
      '/account/21096536',
      queryParams: {
        'session_id': sessionId,
      },
      onSucess: (json) => User.fromJson(json),
    );
    return result.when(
      (_) => null,
      (user) => user,
    );
  }
}
