import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repositories/trending_repository.dart';
import '../../../../domain/typedefs.dart';
import '../../../global/utils/get_image_url.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  late final Future<EitherListMedia> _future;

  @override
  void initState() {
    final TrendingRepository repository = context.read();
    _future = repository.getMoviesAndSeries(
      TimeWindow.day,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: FutureBuilder<EitherListMedia>(
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
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    final media = list[index];
                    return Image.network(
                      getImageUrl(media.posterPath),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
