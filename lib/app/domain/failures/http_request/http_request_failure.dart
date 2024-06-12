import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_failure.freezed.dart';

@freezed
class HttpRequestFailure with _$HttpRequestFailure {
  factory HttpRequestFailure.notFound() = NotFound;
  factory HttpRequestFailure.network() = Network;
  factory HttpRequestFailure.unauthorized() = Unauthorized;
  factory HttpRequestFailure.unknown() = Unknown;
}
