import 'package:flutter/material.dart';

import '/utils/utils.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
        opacity: 0.2,
        child: GridView.count(
          crossAxisCount: 10,
          children: List.generate(200, (index) => loadingCenterPadding()),
        ),
      ),
      const Center(
        child: Text(
          'Coming soon!',
          style: TextStyle(fontSize: 60),
        ),
      ),
    ]);
  }
}
