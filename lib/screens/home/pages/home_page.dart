import 'package:flutter/material.dart';
import '/firebase/firestore_methdos.dart';
import '/utils/routes.dart';
import '/utils/utils.dart';
import '/models/user_model.dart' as model;
import '/widgets/coins_list.dart';
import '/firebase/auth_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double ballance;
  late final model.User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    _user = await AuthMethdods.getCurrentUser();
    ballance = await FirestoreMethods.calculateBallance();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome back',
                      style: Theme.of(context).textTheme.titleLarge),
                  _isLoading
                      ? loadingPadding()
                      : TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.profile);
                          },
                          child: Text('@${_user.username}',
                              style: const TextStyle(fontSize: 20)),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Total Ballance (USD)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            _isLoading
                ? loadingPadding()
                : Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      '≈ \$$ballance',
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
              child: CoinsList(type: CoinsListType.liked),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Your holdings',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: 500,
              child: CoinsList(type: CoinsListType.owned),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
