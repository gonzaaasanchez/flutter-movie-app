import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import 'app/app.dart';
import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/movies_repository_impl.dart';
import 'app/data/repositories_implementation/preferences_repository_impl.dart';
import 'app/data/repositories_implementation/trending_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movies_api.dart';
import 'app/data/services/remote/trending_api.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/movies_repository.dart';
import 'app/domain/repositories/preferences_repository.dart';
import 'app/domain/repositories/trending_repository.dart';
import 'app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sessionService = SessionService(
    const FlutterSecureStorage(),
  );
  //TODO add env files
  // https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files/
  final http = Http(
    client: Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey:
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGFmNjk3NTlkYWMzYmM4NDcxMDcwZmZkOWJmZjJlNSIsInN1YiI6IjY1ZjA3YzcxOTQ2MzE4MDE4NTYyMjM1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mWsKruewG29yByI3woP4JAoHX_Pwn2AE4pIzI1rJMjc',
  );
  final accountApi = AccountApi(
    http,
    sessionService,
  );
  final systemDarkMode = ui.PlatformDispatcher.instance.platformBrightness == Brightness.dark;
  final sharedPreferences = await SharedPreferences.getInstance();
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
        Provider<TrendingRepository>(
          create: (_) => TrendingRepositoryImpl(
            TrendingApi(http),
          ),
        ),
        Provider<MoviesRepository>(
          create: (_) => MoviesRepositoryImp(
            MoviesApi(http),
          ),
        ),
        Provider<PreferencesRepository>(
          create: (_) => PreferencesRepositoryImpl(
            sharedPreferences,
          ),
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final PreferencesRepository preferencesRepository = context.read();
            return ThemeController(
              preferencesRepository.darkMode ?? systemDarkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
      ],
      child: const Application(),
    ),
  );
}
