import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_input.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/landing/sections/landing_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  StateLoginPageState createState() => StateLoginPageState();
}

class StateLoginPageState extends State<LoginPage> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: const [LandingSectionLogin()],
    ));
  }
}
