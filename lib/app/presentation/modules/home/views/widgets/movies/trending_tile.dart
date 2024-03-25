import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/media/media.dart';
import '../../../../../global/utils/get_image_url.dart';
import '../../../../../routes/routes.dart';

class TrendingTile extends StatelessWidget {
  const TrendingTile({
    super.key,
    required this.media,
    required this.width,
    this.showData = true,
  });
  final Media media;
  final double width;
  final bool showData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (media.type == MediaType.movie) {
          Navigator.pushNamed(
            context,
            Routes.movie,
            arguments: media.id,
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: ExtendedImage.network(
                  getImageUrl(media.posterPath),
                  fit: BoxFit.cover,
                  // TODO handle custom loading widget
                  // loadStateChanged: (state) {
                  //   if (state.extendedImageLoadState == LoadState.loading) {
                  //     return Container(
                  //       color: Colors.red,
                  //     );
                  //   }
                  //   return state.completedWidget;
                  // },
                ),
              ),
              if (showData)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Opacity(
                    opacity: 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Chip(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          label: Text(
                            media.voteAverage.toStringAsFixed(1),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Chip(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          label: Icon(
                            media.type == MediaType.movie ? Icons.movie : Icons.tv,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
