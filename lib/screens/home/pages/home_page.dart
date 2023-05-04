import 'package:coin_sky_0/firebase/auth_methods.dart';
import 'package:coin_sky_0/utils/routes.dart';
import 'package:coin_sky_0/utils/utils.dart';
import 'package:coin_sky_0/widgets/coins_list.dart';
import 'package:flutter/material.dart';

import '/models/user_model.dart' as model;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final model.User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    _user = await AuthMethdods.getCurrentUser();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: !_isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Welcome back',
                            style: Theme.of(context).textTheme.titleLarge),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.profile);
                          },
                          child: Text('@${_user.username}',
                              style: const TextStyle(fontSize: 20)),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Total Ballance (USD)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                '≈ \$2,470.53',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Your favorite coins',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: 300,
              child: CoinsList(type: coinsListType.liked),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Your open positions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
