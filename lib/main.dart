import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'app/app.dart';
import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';

void main() {
  runApp(
    Injector(
      connectivityRepository: ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      ),
      authenticationRepository: AuthenticationRepositoryImpl(
        AuthenticationApi(
          Http(
            client: http.Client(),
            baseUrl: 'https://api.themoviedb.org/3',
            apiKey:
                'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGFmNjk3NTlkYWMzYmM4NDcxMDcwZmZkOWJmZjJlNSIsInN1YiI6IjY1ZjA3YzcxOTQ2MzE4MDE4NTYyMjM1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mWsKruewG29yByI3woP4JAoHX_Pwn2AE4pIzI1rJMjc',
          ),
        ),
        const FlutterSecureStorage(),
      ),
      child: const Application(),
    ),
  );
}
