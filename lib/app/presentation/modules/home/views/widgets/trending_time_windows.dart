import 'package:flutter/material.dart';

import '../../../../../domain/enums.dart';

class TrendingTimeWindows extends StatelessWidget {
  const TrendingTimeWindows({
    super.key,
    required this.timeWindow,
    required this.onChanged,
  });
  final TimeWindow timeWindow;
  final Function(TimeWindow) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Trending',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color: const Color(0xfff0f0f0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<TimeWindow>(
                  underline: const SizedBox.shrink(),
                  isDense: true,
                  items: const [
                    DropdownMenuItem(
                      value: TimeWindow.day,
                      child: Text('Last 24hs'),
                    ),
                    DropdownMenuItem(
                      value: TimeWindow.week,
                      child: Text('Last week'),
                    ),
                  ],
                  value: timeWindow,
                  onChanged: (newTimeWindow) {
                    if (newTimeWindow != null && timeWindow != newTimeWindow) {
                      onChanged(newTimeWindow);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
