import '../either/either.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/media/media.dart';
import '../models/user/user.dart';

abstract class AccountRepository {
  Future<User?> getUserData();
  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
    MediaType mediaType,
  );
  Future<Either<HttpRequestFailure, void>> setFavorite({
    required int mediaID,
    required MediaType mediaType,
    required bool favorite,
  });
}
