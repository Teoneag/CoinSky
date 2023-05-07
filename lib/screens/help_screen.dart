import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset('assets/logo_CoinSky_1_2.svg'),
          ),
          const Text(
            'If you need help, write me at teodor.neagoe.climber@gmail.com',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
