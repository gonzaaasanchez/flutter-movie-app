import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/failures/sign_in_failures.dart';
import '../../../../global/controller/session_controller.dart';
import '../../../../routes/routes.dart';
import '../../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Provider.of(context);
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
    result.when((failure) {
      final message = () {
        if (failure is NotFound) {
          return 'Not found';
        }
        if (failure is Unauthorized) {
          return 'Invalid password';
        }
        if (failure is Network) {
          return 'Network error';
        }
        return 'Error';
      }();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }, (user) {
      final SessionController sessionController = context.read();
      sessionController.setUser(user);
      Navigator.pushReplacementNamed(
        context,
        Routes.home,
      );
    });
  }
}
