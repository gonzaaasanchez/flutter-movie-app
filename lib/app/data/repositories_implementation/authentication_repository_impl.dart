import '../../domain/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';
import '../services/remote/authentication_api.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._authenticationApi,
    this._accountApi,
    this._sessionService,
  );
  final AuthenticationApi _authenticationApi;
  final AccountApi _accountApi;
  final SessionService _sessionService;

  @override
  Future<bool> get isLogged async {
    final sessionId = await _sessionService.sessionId;
    return sessionId != null;
  }

  @override
  Future<void> signOut() {
    return _sessionService.signOut();
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
            return sessionResult.when(
              (failure) async {
                return Either.left(failure);
              },
              (sessionId) async {
                _sessionService.saveSessionId(sessionId);
                final user = await _accountApi.getAccount(sessionId);
                if (user == null) {
                  return Either.left(SignInFailure.unknown);
                }
                return Either.right(user);
              },
            );
          },
        );
      },
    );
  }
}
