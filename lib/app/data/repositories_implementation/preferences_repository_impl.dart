import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/enums.dart';
import '../../domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  PreferencesRepositoryImpl(
    this._sharedPreferences,
  );

  final SharedPreferences _sharedPreferences;
  @override
  bool? get darkMode {
    return _sharedPreferences.getBool(Preference.darkMode.name);
  }

  @override
  Future<void> setDarkMode(bool darkMode) {
    return _sharedPreferences.setBool(Preference.darkMode.name, darkMode);
  }
}
