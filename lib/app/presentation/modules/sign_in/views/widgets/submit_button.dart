import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/routes.dart';
import '../../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = context.watch();
    if (controller.state.fetching) {
      return const CircularProgressIndicator();
    } else {
      return MaterialButton(
        onPressed: () {
          final isValid = Form.of(context).validate();
          if (isValid) {
            _submit(context);
          }
        },
        color: Colors.blue,
        child: const Text('Sign in'),
      );
    }
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController controller = context.read();

    final result = await controller.submit();

    if (!controller.mounted) {
      return;
    }
    result.when(
      left: (failure) {
        final message = failure.when(
          notFound: () => 'Not found',
          notVerified: () => 'Email not verified',
          network: () => 'Network error',
          unauthorized: () => 'Invalid password',
          unknown: () => 'Error',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
      right: (_) => Navigator.pushReplacementNamed(
        context,
        Routes.home,
      ),
    );
  }
}
