import 'package:flutter/material.dart';

import 'generated/assets.gen.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        initialRoute: Routes.splash,
        routes: appRoutes,
        onUnknownRoute: (_) => MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Assets.svgs.error404.svg(),
            ),
          ),
        ),
      ),
    );
  }
}
