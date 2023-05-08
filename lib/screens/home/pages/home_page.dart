import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/widgets/coins_list.dart';
import '/widgets/ballance.dart';
import '/widgets/welcome_back.dart';

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
            const WelcomeBack(),
            const Ballance(),
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
