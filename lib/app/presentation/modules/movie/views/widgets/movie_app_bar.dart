import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/controller/favorites/favorites_controller.dart';
import '../../../../utils/set_favorite.dart';
import '../../controller/movie_controller.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    final FavoritesController favoritesController = context.watch();
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      actions: controller.state.mapOrNull(
        loaded: (movieState) => [
          favoritesController.state.maybeMap(
            orElse: () => const SizedBox.shrink(),
            loaded: (favoritesState) => IconButton(
              onPressed: () => setFavorite(
                context: context,
                media: movieState.movie.toMedia(),
                mounted: () => controller.mounted,
              ),
              icon: Icon(
                favoritesState.movies.containsKey(movieState.movie.id) ? Icons.favorite : Icons.favorite_outline,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
