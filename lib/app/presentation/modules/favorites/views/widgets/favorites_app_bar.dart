import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('Favorites'),
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 10),
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          // Use the default focused overlay color
          return states.contains(MaterialState.focused) ? null : Colors.transparent;
        }),
        controller: tabController,
        indicator: const _Decoration(
          color: Colors.blue,
          width: 20,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        tabs: const [
          SizedBox(
            height: 30,
            child: Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Movies',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            child: Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Series',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  const _Decoration({required this.color, required this.width});

  final Color color;
  final double width;
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _Painter(
        color,
        width,
      );
}

class _Painter extends BoxPainter {
  _Painter(this.color, this.width);

  final Color color;
  final double width;
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final paint = Paint()..color = color;
    final size = configuration.size ?? Size.zero;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          (size.width * 0.5) + offset.dx - (width * 0.5),
          size.height * 0.9,
          width,
          width * 0.3,
        ),
        const Radius.circular(4),
      ),
      paint,
    );
  }
}
