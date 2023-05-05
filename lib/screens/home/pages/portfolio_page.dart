import 'package:flutter/material.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            'Your holdings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
