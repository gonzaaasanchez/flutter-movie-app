import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/presentation/global/controller/session_controller.dart';

void main() {
  final sessionService = SessionService(
    const FlutterSecureStorage(),
  );
  final http = Http(
    client: Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey:
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGFmNjk3NTlkYWMzYmM4NDcxMDcwZmZkOWJmZjJlNSIsInN1YiI6IjY1ZjA3YzcxOTQ2MzE4MDE4NTYyMjM1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mWsKruewG29yByI3woP4JAoHX_Pwn2AE4pIzI1rJMjc',
  );
  final accountApi = AccountApi(
    http,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (_) => AccountRepositoryImpl(
            accountApi,
            sessionService,
          ),
        ),
        Provider<ConnectivityRepository>(
          create: (_) => ConnectivityRepositoryImpl(
            Connectivity(),
            InternetChecker(),
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImpl(
            AuthenticationApi(http),
            accountApi,
            sessionService,
          ),
          child: const Application(),
        ),
        ChangeNotifierProvider(
          create: (context) => SessionController(
            authenticationRepository: context.read(),
          ),
        ),
      ],
      child: const Application(),
    ),
  );
}
