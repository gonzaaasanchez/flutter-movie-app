import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../../domain/typedefs.dart';
import 'trending_tile.dart';
import 'trending_time_windows.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  TrendingRepository get _repository => context.read();
  late Future<EitherListMedia> _future;
  TimeWindow _timeWindow = TimeWindow.day;

  @override
  void initState() {
    super.initState();
    _future = _repository.getMoviesAndSeries(_timeWindow);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindows(
          timeWindow: _timeWindow,
          onChanged: (timeWindow) {
            setState(() {
              _timeWindow = timeWindow;
              _future = _repository.getMoviesAndSeries(
                _timeWindow,
              );
            });
          },
        ),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.65;
              return Center(
                child: FutureBuilder<EitherListMedia>(
                  key: ValueKey(_future), // this forces the render (to show the loader)
                  future: _future,
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return snapshot.data!.when(
                      left: (failure) => Text(
                        failure.toString(),
                      ),
                      right: (list) {
                        return ListView.separated(
                          separatorBuilder: (_, __) => const SizedBox(width: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            final media = list[index];
                            return TrendingTile(
                              media: media,
                              width: width,
                            );
                          },
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
