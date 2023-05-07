import 'package:flutter/material.dart';
import '/firebase/firestore_methdos.dart';
import '/utils/routes.dart';
import '/utils/utils.dart';
import '/widgets/coins_list.dart';
import '/firebase/auth_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Total Ballance (USD)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            StreamBuilder<double>(
              stream: FirestoreMethods.calculateBalanceStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return loadingCenterPadding();
                return Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    '≈ \$${snapshot.data}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              },
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
              padding: const EdgeInsets.only(left: 20, bottom: 10),
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
