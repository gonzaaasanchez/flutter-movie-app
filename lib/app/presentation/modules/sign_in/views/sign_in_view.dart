import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/sign_in_controller.dart';
import '../controller/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        const SignInState(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(
                builder: (context) {
                  final contoller = Provider.of<SignInController>(context);
                  return AbsorbPointer(
                    absorbing: contoller.state.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => contoller.onUsernameChanged(value),
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
                          onChanged: (value) => contoller.onPasswordChanged(value),
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
