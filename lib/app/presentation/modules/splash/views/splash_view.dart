import 'package:flutter/material.dart';

import '../../../../app.dart';
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
    final injector = Injector.of(context);
    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hasInternet;
    debugPrint('Has internet: $hasInternet');
    if (hasInternet) {
      final authenticationRepository = injector.authenticationRepository;
      final isLogged = await authenticationRepository.isLogged;
      debugPrint('Is logged: $isLogged');
      if (isLogged) {
        final user = await authenticationRepository.getUserData();
        if (mounted) {
          if (user != null) {
            _goTo(Routes.home);
          } else {
            _goTo(Routes.signIn);
          }
        }
      } else if (mounted) {
        _goTo(Routes.signIn);
      }
    } else {
      _goTo(Routes.offline);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
    );
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
