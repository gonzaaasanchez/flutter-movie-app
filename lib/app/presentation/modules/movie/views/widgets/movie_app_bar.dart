import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/movie_controller.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
