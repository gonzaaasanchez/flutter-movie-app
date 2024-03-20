import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/repositories/authentication_repository.dart';
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
    final SignInController contoller = context.read();
    contoller.onFetchingChanged(true);

    final result = await context.read<AuthenticationRepository>().signIn(
          contoller.state.username,
          contoller.state.password,
        );
    if (!contoller.mounted) {
      return;
    }
    result.when((failure) {
      contoller.onFetchingChanged(false);

      final message = {
        SignInFailure.notFound: 'Not found',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknown: 'Error',
        SignInFailure.network: 'Network error',
      }[failure];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
        ),
      );
    }, (user) {
      Navigator.pushReplacementNamed(
        context,
        Routes.home,
      );
    });
  }
}
