import 'package:amazon_app/constants.dart';
import 'package:amazon_app/provider/userProvider.dart';
import 'package:amazon_app/routes.dart';
import 'package:amazon_app/screens/signIn.dart';
import 'package:amazon_app/services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homeScreen/homeScreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    authServices.getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.greyBackgroundCOlor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
        // useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).users.token.isNotEmpty
          ? const HomeScreen()
          : const SignIn(),
    );
  }
}
