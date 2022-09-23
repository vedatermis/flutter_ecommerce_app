import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(settings: const RouteSettings(name: routeName), builder: (builder) => const SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/'));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            const SizedBox(height: 30),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Zero To Unicorn',
                style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
