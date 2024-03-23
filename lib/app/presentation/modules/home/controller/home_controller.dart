import '../../../../domain/repositories/trending_repository.dart';
import '../../../global/state_notifiers.dart';
import '../state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state, {
    required this.trendingRepository,
  });
  final TrendingRepository trendingRepository;
  Future<void> init() async {
    loadMoviesAndSeries();
    loadPerformers();
  }

  Future<void> loadMoviesAndSeries() async {
    final result = await trendingRepository.getMoviesAndSeries(
      state.moviesAndSeries.timeWindow,
    );
    result.when(
      left: (_) {
        state = state.copyWith(
          moviesAndSeries: MoviesAndSeriesState.failed(
            state.moviesAndSeries.timeWindow,
          ),
        );
      },
      right: (list) {
        state = state.copyWith(
          moviesAndSeries: MoviesAndSeriesState.loaded(
            list: list,
            timeWindow: state.moviesAndSeries.timeWindow,
          ),
        );
      },
    );
  }

  Future<void> loadPerformers() async {
    final performersResult = await trendingRepository.getPerformers();
    performersResult.when(
      left: (_) {
        state = state.copyWith(
          performers: const PerformersState.failed(),
        );
      },
      right: (list) {
        state = state.copyWith(
          performers: PerformersState.loaded(list),
        );
      },
    );
  }
}
