import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/widgets/request_failed.dart';
import '../controller/movie_controller.dart';
import '../controller/state/movie_state.dart';
import 'widgets/movie_content.dart';

class MovieView extends StatelessWidget {
  const MovieView({
    super.key,
    required this.movieId,
  });
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieController(
        const MovieState.loading(),
        moviesRepository: context.read(),
        movieId: movieId,
      )..init(),
      builder: (context, child) {
        final MovieController controller = context.watch();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            actions: controller.state.mapOrNull(
              loaded: (_) => [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline_outlined,
                  ),
                ),
              ],
            ),
          ),

          /// TODO
          ///  .when: returns properties of the classes
          ///  .map: returns instance of the classes
          body: controller.state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => RequestFailed(
              onRetry: () => controller.init(),
            ),
            loaded: (state) => MovieContent(
              state: MovieStateLoaded(
                state.movie,
              ),
            ),
          ),
        );
      },
    );
  }
}
