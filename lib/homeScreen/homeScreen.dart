import 'package:amazon_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).users;

    return Scaffold(
      body: Text(user.toJson()),
    );
  }

  static const String route = "/hoemscreen";
}
