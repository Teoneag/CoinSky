import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/widgets/coins_list.dart';
import '/firebase/firestore_methdos.dart';

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
