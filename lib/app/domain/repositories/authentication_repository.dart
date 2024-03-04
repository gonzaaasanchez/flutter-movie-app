import '../models/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isLogged;
  Future<User> getUserData();
}
