import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class TrendingApi {
  TrendingApi(this._http);

  final Http _http;

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  ) async {
    final result = await _http.request(
      '/trending/all/${timeWindow.name}',
      onSucess: (json) {
        final list = json['result'] as List<Json>;
        return list
            .where(
              (element) => element['media_type'] != 'person',
            )
            .map(
              (e) => Media.fromJson(e),
            )
            .toList();
      },
    );
    return result.when(
      left: handleHttpFailure,
      right: (media) => Either.right(media),
    );
  }
}
