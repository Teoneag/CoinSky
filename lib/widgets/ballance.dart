import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/firebase/firestore_methdos.dart';

class Ballance extends StatelessWidget {
  const Ballance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                '≈ \$${formatN(snapshot.data ?? 0.0)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}
