import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/widgets/coins_list.dart';
import '/widgets/ballance.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Virtual portofolio',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          const Ballance(),
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
        ],
      ),
    );
  }
}
