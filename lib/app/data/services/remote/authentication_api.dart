import '../../../domain/either.dart';
import '../../../domain/failures/sign_in_failure.dart';
import '../../http/http.dart';

class AuthenticationApi {
  AuthenticationApi(
    this._http,
  );

  final Http _http;

  Either<SignInFailure, String> _handleFailure(HttpFailure failure) {
    if (failure.statusCode != null) {
      switch (failure.statusCode) {
        case 401:
          return Either.left(SignInFailure.unauthorized());
        case 404:
          return Either.left(SignInFailure.notFound());
        default:
          return Either.left(SignInFailure.unknown());
      }
    }
    if (failure.exception is NetworkException) {
      return Either.left(SignInFailure.network());
    }
    return Either.left(SignInFailure.unknown());
  }

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request(
      '/authentication/token/new',
      needsAuthentication: true,
      onSucess: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
    );
    return result.when(
      left: _handleFailure,
      right: (requestToken) => Either.right(requestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      method: HttpMethod.post,
      needsAuthentication: true,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
      onSucess: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
    );
    return result.when(
      left: _handleFailure,
      right: (newRequestToken) => Either.right(newRequestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSession(
    String requestToken,
  ) async {
    final result = await _http.request(
      '/authentication/session/new',
      method: HttpMethod.post,
      body: {
        'request_token': requestToken,
      },
      onSucess: (responseBody) {
        final json = responseBody as Map;
        return json['session_id'] as String;
      },
    );
    return result.when(
      left: _handleFailure,
      right: (sessionId) => Either.right(sessionId),
    );
  }
}
