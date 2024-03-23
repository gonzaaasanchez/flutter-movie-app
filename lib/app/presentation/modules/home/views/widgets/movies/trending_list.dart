import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../global/widgets/request_failed.dart';
import '../../../controller/home_controller.dart';
import 'trending_tile.dart';
import 'trending_time_windows.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();
    final state = controller.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindows(
          timeWindow: state.timeWindow,
          onChanged: (timeWindow) {},
        ),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.65;
              return Center(
                child: Builder(
                  builder: (_) {
                    if (state.loading) {
                      const CircularProgressIndicator();
                    }
                    if (state.moviesAndSeries == null) {
                      RequestFailed(onRetry: () {});
                    }
                    return ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.moviesAndSeries!.length,
                      itemBuilder: (_, index) {
                        final media = state.moviesAndSeries![index];
                        return TrendingTile(
                          media: media,
                          width: width,
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
