import '../../../domain/models/user/user.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../state_notifiers.dart';

class SessionController extends StateNotifier<User?> {
  SessionController({
    required this.authenticationRepository,
  }) : super(null);
  final AuthenticationRepository authenticationRepository;

  void setUser(User user) {
    state = user;
  }

  Future<void> signOut() async {
    await authenticationRepository.signOut();
    onlyUpdate(null);
  }
}
