import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/theme.dart';
import '/widgets/log_out_dialog.dart';
import '/firebase/firestore_methdos.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'General settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Consumer<ThemeController>(
              builder: (context, themeController, child) {
                return SwitchListTile(
                  title: const Text('Theme'),
                  value: themeController.themeMode == ThemeModeType.dark,
                  onChanged: (value) {
                    themeController.setThemeMode(
                        value ? ThemeModeType.dark : ThemeModeType.light);
                  },
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'User settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LogOutDialog();
                  },
                );
              },
              child: const Text('Log out'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Wallet settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Reset wallet'),
                      content: const Text(
                          'Are you sure u want to reset your wallet? You will lose all your data!'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () async {
                              await FirestoreMethods.resetWallet();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Reset wallet')),
                      ],
                    );
                  },
                );
              },
              child: const Text('Reset wallet'),
            ),
          ),
        ],
      ),
    );
  }
}
