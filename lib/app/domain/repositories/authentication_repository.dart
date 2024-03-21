import '../either.dart';
import '../failures/sign_in_failures.dart';
import '../models/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isLogged;

  Future<void> signOut();
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  );
}
