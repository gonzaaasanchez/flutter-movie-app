import 'either/either.dart';
import 'failures/http_request/http_request_failure.dart';
import 'models/performer/performer.dart';

typedef Json = Map<String, dynamic>;
typedef JsonString = Map<String, String>;

typedef EitherListPerformer = Either<HttpRequestFailure, List<Performer>>;
