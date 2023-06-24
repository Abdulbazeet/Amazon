import 'dart:convert';

import 'package:amazon_app/errorHandling.dart';
import 'package:amazon_app/homeScreen/homeScreen.dart';
import 'package:amazon_app/provider/userProvider.dart';
import 'package:amazon_app/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/users.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  // signUp
  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Users users = Users(name, '', email, '', '', '', password);
      http.Response response = await http.post(Uri.parse("$uri/api/signUp"),
          body: users.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json;charset=UTF-8"
          });
      // ignore: use_build_context_synchronously
      ErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          ShowSnackBar(context,
              'Account successfully created, login with the same credentials');
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

// signIn
  void SignIn(
      {required BuildContext context,
      required String password,
      required String email}) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signIn"),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8"
        },
        body: jsonEncode(
          {'email': email, 'password': password},
        ),
      );
      print(response.body);
      // ignore: use_build_context_synchronously
      ErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          await sharedPreferences.setString(
              'userToken', jsonDecode(response.body)['token']);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
          // ShowSnackBar(context, response.body);
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
      print(e);
    }
  }

  // getUser Data
  void getData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('userToken');
      if (token == null) {
        prefs.setString('userToken', '');
      }
      var tokenResponse = await http.post(
        Uri.parse('$uri/isTokenValid'),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "userToken": token!
        },
      );
      var response = jsonDecode(tokenResponse.body);
      if (response == true) {
        http.Response userResponse = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              "Content-Type": "application/json;charset=UTF-8",
              "userToken": token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      ;
    }
  }
}
