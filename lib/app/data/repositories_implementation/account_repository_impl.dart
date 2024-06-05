import '../../domain/either/either.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../../domain/models/media/media.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(
    this._accountApi,
    this._sessionService,
  );

  final AccountApi _accountApi;
  final SessionService _sessionService;

  @override
  Future<User?> getUserData() async {
    final user = await _accountApi.getAccount(
      await _sessionService.sessionId ?? '',
    );
    if (user != null) {
      await _sessionService.saveAccountId(user.id.toString());
    }
    return user;
  }

  @override
  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(MediaType mediaType) {
    return _accountApi.getFavorites(mediaType);
  }
}
