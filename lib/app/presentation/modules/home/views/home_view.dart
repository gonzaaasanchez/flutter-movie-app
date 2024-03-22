import 'package:flutter/material.dart';

import 'widgets/trending_list.dart';
import 'widgets/trending_performers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            TrendingList(),
            SizedBox(height: 20),
            TrendingPerformers(),
          ],
        ),
      ),
    );
  }
}
