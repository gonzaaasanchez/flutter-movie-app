import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/theme_controller.dart';
import '../../../global/extensions/build_context_extension.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              // TODO ADD functionality
              /// Switch: 'Use system configuration'
              /// which disables the user prefence when on
              /// and uses user prefence when off
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: context.darkMode,
                onChanged: (value) => context.read<ThemeController>().onChanged(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
