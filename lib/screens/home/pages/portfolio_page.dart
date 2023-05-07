import 'package:coin_sky_0/firebase/firestore_methdos.dart';
import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/widgets/coins_list.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late double ballance;
  bool _isLoading = true;
  @override
  void initState() {
    _fetch();
    super.initState();
  }

  Future _fetch() async {
    ballance = await FirestoreMethods.calculateBallance();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
          Row(
            children: [
              Column(
                children: [
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
                ],
              ),
            ],
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
