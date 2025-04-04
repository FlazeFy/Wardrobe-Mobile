import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/landing/sections/landing_features.dart';
import 'package:wardrobe/screens/landing/sections/landing_feedback.dart';
import 'package:wardrobe/screens/landing/sections/landing_login.dart';
import 'package:wardrobe/screens/landing/sections/landing_welcoming.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  StateLoginPageState createState() => StateLoginPageState();
}

class StateLoginPageState extends State<LoginPage> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  Widget sectionDivider() {
    return const Column(children: [
      SizedBox(height: spaceJumbo),
      Divider(color: darkColor),
      SizedBox(height: spaceXLG),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: [
        const LandingSectionLogin(),
        sectionDivider(),
        const LandingSectionWelcoming(),
        sectionDivider(),
        const LandingSectionFeedback(),
        sectionDivider(),
        const LandingSectionFeatures()
      ],
    ));
  }
}
