import 'package:flutter/material.dart';

import '/utils/routes.dart';
import '/firebase/auth_methods.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log out'),
      content: const Text('Are you sure u want to log out?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () async {
              await AuthMethdods.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.login, (route) => false);
            },
            child: const Text('Log out')),
      ],
    );
  }
}
