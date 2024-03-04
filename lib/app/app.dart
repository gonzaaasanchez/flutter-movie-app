import 'package:flutter/material.dart';

import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.splash,
      routes: appRoutes,
    );
  }
}
