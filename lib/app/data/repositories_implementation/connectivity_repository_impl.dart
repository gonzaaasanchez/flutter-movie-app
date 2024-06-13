import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/repositories/connectivity_repository.dart';
import '../services/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {

  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  );
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;

  @override
  Future<bool> get hasInternet async {
    // TODO migrate
    // use onConnectivityChanged as the documentation says
    final results = await _connectivity.checkConnectivity();
    if (results.length == 1 && results.first == ConnectivityResult.none) {
      return false;
    }
    return _internetChecker.hasInternet();
  }
}
