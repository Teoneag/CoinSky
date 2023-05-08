import 'package:flutter/material.dart';
import '/firebase/auth_methods.dart';
import '/utils/routes.dart';
import '/utils/utils.dart';

class WelcomeBack extends StatelessWidget {
  const WelcomeBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome back', style: Theme.of(context).textTheme.titleLarge),
          FutureBuilder(
            future: AuthMethdods.getCurrentUser(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return loadingCenterPadding();
              return TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.profile);
                },
                child: Text('@${snapshot.data!.username}',
                    style: const TextStyle(fontSize: 20)),
              );
            },
          ),
        ],
      ),
    );
  }
}
