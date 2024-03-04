import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';

void main() {
  runApp(
    Injector(
      connectivityRepository: ConnectivityRepositoryImpl(),
      authenticationRepository: AuthenticationRepositoryImpl(),
      child: const Application(),
    ),
  );
}
