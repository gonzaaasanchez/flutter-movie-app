import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/sign_in_controller.dart';
import '../controller/state/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        const SignInState(),
        sessionController: context.read(),
        favoritesController: context.read(),
        authenticationRepository: context.read(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(
                builder: (context) {
                  final SignInController controller = context.watch();
                  return AbsorbPointer(
                    absorbing: controller.state.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => controller.onUsernameChanged(value),
                          decoration: const InputDecoration(hintText: 'Username'),
                          validator: (value) {
                            value = value?.toLowerCase().trim() ?? '';
                            if (value.isEmpty) {
                              return 'Invalid username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => controller.onPasswordChanged(value),
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: (value) {
                            value = value?.replaceAll(' ', '') ?? '';
                            if (value.length < 4) {
                              return 'Invalid password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const SubmitButton(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
