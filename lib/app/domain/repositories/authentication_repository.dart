import '../either.dart';
import '../enums.dart';
import '../models/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isLogged;
  Future<User?> getUserData();
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  );
}
