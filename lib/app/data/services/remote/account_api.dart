import '../../../domain/either/either.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/user/user.dart';
import '../../http/http.dart';
import '../local/session_service.dart';
import '../utils/handle_failure.dart';

class AccountApi {
  AccountApi(
    this._http,
    this._sessionService,
  );

  final Http _http;
  final SessionService _sessionService;

  Future<User?> getAccount(String sessionId) async {
    // TODO where to get account id?
    final result = await _http.request(
      '/account/21096536',
      queryParams: {
        'session_id': sessionId,
      },
      onSucess: (json) => User.fromJson(json),
    );
    return result.when(
      left: (_) => null,
      right: (user) => user,
    );
  }

  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
    MediaType mediaType,
  ) async {
    final accountId = await _sessionService.accountId;
    final sessionId = await _sessionService.sessionId ?? '';

    final result = await _http.request(
      '/account/$accountId/favorite/${mediaType.path}',
      queryParams: {
        'session_id': sessionId,
      },
      onSucess: (json) {
        final list = json['results'] as List;
        final iterable = list.map((e) {
          final media = Media.fromJson({
            ...e,
            'media_type': mediaType.name,
          });
          return MapEntry(media.id, media);
        });
        final map = <int, Media>{}..addEntries(iterable);
        return map;
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (value) => Either.right(value),
    );
  }

  Future<Either<HttpRequestFailure, void>> setFavorite({
    required int mediaID,
    required MediaType mediaType,
    required bool favorite,
  }) async {
    final accountId = await _sessionService.accountId;
    final sessionId = await _sessionService.sessionId ?? '';

    final result = await _http.request(
      '/account/$accountId/favorite',
      queryParams: {
        'session_id': sessionId,
      },
      body: {
        'media_type': mediaType.name,
        'media_id': mediaID,
        'favorite': favorite,
      },
      method: HttpMethod.post,
      onSucess: (_) => null,
    );
    return result.when(
      left: handleHttpFailure,
      right: (_) => Either.right(null),
    );
  }
}
