import 'package:flutter/material.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome back',
                      style: Theme.of(context).textTheme.titleLarge),
                  _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
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
              child: CoinsList(type: CoinsListType.liked),
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
