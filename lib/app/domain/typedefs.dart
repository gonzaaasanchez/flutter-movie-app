import 'either/either.dart';
import 'failures/http_request/http_request_failure.dart';
import 'models/media/media.dart';
import 'models/performer/performer.dart';

typedef Json = Map<String, dynamic>;
typedef JsonString = Map<String, String>;

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;
typedef EitherListPerformer = Either<HttpRequestFailure, List<Performer>>;
