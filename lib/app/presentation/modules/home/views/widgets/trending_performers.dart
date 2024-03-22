import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../../domain/typedefs.dart';

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  late Future<EitherListPerformer> _future;
  @override
  void initState() {
    super.initState();
    _future = context.read<TrendingRepository>().getPerformers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EitherListPerformer>(
      future: _future,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data!.when(
          left: (_) => const Text('Error'),
          right: (list) {
            return const Text('Performers');
          },
        );
      },
    );
  }
}
