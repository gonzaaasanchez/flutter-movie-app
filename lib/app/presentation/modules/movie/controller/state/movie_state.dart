import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/movie/movie.dart';

part 'movie_state.freezed.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.loading() = MovieStateLoading;
  const factory MovieState.failed() = MovieStateFailed;
  const factory MovieState.loaded(
    Movie movie,
  ) = MovieStateLoaded;
}
