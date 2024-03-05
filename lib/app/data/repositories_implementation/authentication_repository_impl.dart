import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<bool> get isLogged {
    return Future.value(true);
  }

  @override
  Future<User?> getUserData() {
    return Future.value(
      User(),
    );
  }
}
