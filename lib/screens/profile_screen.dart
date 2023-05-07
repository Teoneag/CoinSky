import 'package:flutter/material.dart';

import '../firebase/auth_methods.dart';
import '../utils/routes.dart';
import '../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome', style: Theme.of(context).textTheme.titleLarge),
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
          ),
        ],
      ),
    );
  }
}
