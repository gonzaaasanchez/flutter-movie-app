import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media.dart';
import '../../../../global/controller/favorites/state/favorites_state.dart';
import '../../../../global/utils/get_image_url.dart';

class FavoritesContent extends StatelessWidget {
  const FavoritesContent({
    super.key,
    required this.state,
    required this.tabController,
  });
  final FavoritesStateLoaded state;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        FavoritesList(
          items: state.movies.values.toList(),
        ),
        FavoritesList(
          items: state.series.values.toList(),
        ),
      ],
    );
  }
}

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    super.key,
    required this.items,
  });
  final List<Media> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ExtendedImage.network(
                getImageUrl(
                  item.posterPath,
                ),
                width: 60,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: items.length,
    );
  }
}
