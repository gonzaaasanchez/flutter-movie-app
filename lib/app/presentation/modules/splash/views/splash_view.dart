import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/account_repository.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../global/controller/favorites/favorites_controller.dart';
import '../../../global/controller/session_controller.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final routeName = await () async {
      final ConnectivityRepository connectivityRepository = context.read();
      final AuthenticationRepository authenticationRepository = context.read();
      final AccountRepository accountRepository = context.read();
      final SessionController sessionController = context.read();
      final FavoritesController favoritesController = context.read();

      final hasInternet = await connectivityRepository.hasInternet;
      if (!hasInternet) {
        return Routes.offline;
      }

      final isLogged = await authenticationRepository.isLogged;

      if (!isLogged) {
        return Routes.signIn;
      }

      final user = await accountRepository.getUserData();
      if (user != null) {
        sessionController.setUser(user);
        favoritesController.init();
        return Routes.home;
      }

      return Routes.signIn;
    }();

    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        routeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
