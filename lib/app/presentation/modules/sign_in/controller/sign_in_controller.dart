import '../../../global/state_notifiers.dart';
import 'sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(super.state);

  void onUsernameChanged(String text) {
    onlyUpdate(
      state.copyWith(username: text),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(password: text.replaceAll(' ', '')),
    );
  }

  void onFetchingChanged(bool value) {
    state = state.copyWith(fetching: value);
  }
}
