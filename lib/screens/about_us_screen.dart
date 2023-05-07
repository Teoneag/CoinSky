import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset('assets/logo_CoinSky_1_2.svg'),
          ),
          const Text(
            'More info on my',
            style: TextStyle(fontSize: 30),
          ),
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse('https://github.com/Teoneag/CoinSky'));
            },
            child: const Text(
              'GitHub',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
