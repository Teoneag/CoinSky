import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/utils/utils.dart';
import '/utils/routes.dart';
import '/firebase/auth_methods.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();
  final TextEditingController _nameC = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void registerUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethdods.registerUser(
      email: _emailC.text,
      password: _passC.text,
      username: _nameC.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.login, (route) => false);
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // svg image
              SvgPicture.asset(
                'assets/logo_CoinSky_1_2.svg',
                height: 90,
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Please register!',
                  style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _nameC,
                decoration:
                    const InputDecoration(hintText: 'Enter your username'),
              ),
              TextField(
                controller: _emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Enter your email'),
              ),
              TextField(
                controller: _passC,
                keyboardType: TextInputType.visiblePassword,
                decoration:
                    const InputDecoration(hintText: 'Enter your password'),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: registerUser,
                child: _isLoading ? loadingCenter() : const Text('Register'),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: const Text('Log in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
