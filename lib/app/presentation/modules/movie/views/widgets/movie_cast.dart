import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either/either.dart';
import '../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../domain/models/performer/performer.dart';
import '../../../../../domain/repositories/movies_repository.dart';
import '../../../../global/extensions/build_context_extension.dart';
import '../../../../global/utils/get_image_url.dart';
import '../../../../global/widgets/request_failed.dart';

class MovieCast extends StatefulWidget {
  const MovieCast({
    super.key,
    required this.movieId,
  });
  final int movieId;

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  late Future<Either<HttpRequestFailure, List<Performer>>> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  void _initFuture() {
    _future = context.read<MoviesRepository>().getCastByMovie(
          widget.movieId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<Performer>>>(
      key: ValueKey(_future),
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data!.when(
          left: (_) => RequestFailed(
            onRetry: () {
              setState(
                () => _initFuture(),
              );
            },
          ),
          right: (cast) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Cast',
                  style: context.textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (_, index) {
                    final performer = cast[index];
                    return Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (_, constraints) {
                              final size = constraints.maxHeight;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(size / 2),
                                child: ExtendedImage.network(
                                  getImageUrl(
                                    performer.profilePath,
                                  ),
                                  height: size,
                                  width: size,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          performer.name,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
