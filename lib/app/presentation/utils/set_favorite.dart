import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/controller/favorites/favorites_controller.dart';
import '../global/dialogs/show_loader.dart';

Future<void> setFavorite({
  required BuildContext context,
  required media,
  required bool Function() mounted,
}) async {
  final FavoritesController favoritesController = context.read();
  final result = await showLoder(
    context,
    favoritesController.setFavorite(media),
  );
  if (!mounted()) {
    return;
  }

  result.whenOrNull(
    left: (failure) {
      final message = failure.when(
        notFound: () => 'Not found',
        network: () => 'Network error',
        unauthorized: () => 'Invalid password',
        unknown: () => 'Error',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    },
  );
}
