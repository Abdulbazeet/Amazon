import 'package:amazon_app/constants.dart';
import 'package:amazon_app/enum.dart';
import 'package:flutter/material.dart';

import '../common/widget/customField.dart';
import '../common/widget/cutomButton.dart';
import '../services/authServices.dart';

class SignIn extends StatefulWidget {
  static const String routeName = '/signIn';
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Auth? _auth = Auth.signUp;
  AuthServices authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUP() {
    authServices.signUp(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void SignIn() {
    authServices.SignIn(
        context: context,
        password: _passwordController.text,
        email: _emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: _auth == Auth.signUp
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signUp,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val;
                    });
                  }),
              title: const Text(
                'Create Account',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            if (_auth == Auth.signUp)
              Form(
                  key: _signUpFormKey,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: _auth == Auth.signUp
                            ? GlobalVariables.backgroundColor
                            : GlobalVariables.greyBackgroundCOlor),
                    child: Column(
                      children: [
                        CustomField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUP();
                            }
                          },
                          text: 'SignUp',
                        )
                      ],
                    ),
                  )),
            ListTile(
              tileColor: _auth == Auth.signIn
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signIn,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val;
                    });
                  }),
              title: const Text(
                'Sign-In',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            if (_auth == Auth.signIn)
              Form(
                  key: _signInFormKey,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: _auth == Auth.signIn
                            ? GlobalVariables.backgroundColor
                            : GlobalVariables.greyBackgroundCOlor),
                    child: Column(
                      children: [
                        CustomField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              SignIn();
                            }
                          },
                          text: 'Sign In',
                        )
                      ],
                    ),
                  ))
          ],
        ),
      )),
    );
  }
}
