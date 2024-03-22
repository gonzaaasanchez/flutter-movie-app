import 'either/either.dart';
import 'failures/http_request/http_request_failure.dart';
import 'models/media/media.dart';

typedef Json = Map<String, dynamic>;
typedef JsonString = Map<String, String>;

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

