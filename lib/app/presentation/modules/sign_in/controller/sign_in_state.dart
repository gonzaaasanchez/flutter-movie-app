import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@Freezed()
class SignInState with _$SignInState {
  const factory SignInState({
    required String username,
    required String password,
    required bool fetching,
  }) = _SignInState;
}
