import 'package:coin_sky_0/firebase/auth_methods.dart';
import 'package:flutter/material.dart';

import '/models/user_model.dart' as model;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final model.User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    _user = await AuthMethdods.getCurrentUser();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !_isLoading
          ? Text('Welcome ${_user.username}')
          : const CircularProgressIndicator(),
    );
  }
}
