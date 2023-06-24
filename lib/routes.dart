import 'package:amazon_app/homeScreen/homeScreen.dart';
import 'package:amazon_app/screens/signIn.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignIn.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignIn(),
      );
    case HomeScreen.route:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Error'),
          ),
        ),
      );
  }
}
