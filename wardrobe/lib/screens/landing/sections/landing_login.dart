import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_input.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/auth/model/command.dart';
import 'package:wardrobe/modules/api/auth/service/command.dart';
import 'package:wardrobe/organisms/o_bottom_bar.dart';

class LandingSectionLogin extends StatefulWidget {
  const LandingSectionLogin({super.key});

  @override
  StateLandingSectionLogin createState() => StateLandingSectionLogin();
}

class StateLandingSectionLogin extends State<LandingSectionLogin> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  late AuthCommandsService apiCommand;
  String allMsg = "";
  bool isLoadPost = false;

  @override
  void initState() {
    super.initState();
    apiCommand = AuthCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceLG),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [darkInfoBG, infoBG],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AtomsText(
              type: "page-title", text: "Hello There!!!", color: whiteColor),
          const AtomsText(
              type: "content-body",
              text:
                  "Do you have an account? type your username and password to proceed sign in, so you can using this apps"),
          AtomsInput(
            type: "input-text",
            label: "Username",
            controller: usernameCtrl,
          ),
          AtomsInput(
            type: "input-text",
            label: "Password",
            controller: passwordCtrl,
          ),
          Row(
            children: [
              AtomsButton(
                  type: 'btn-success',
                  text: 'Sign In',
                  action: () async {
                    String uname = usernameCtrl.text.trim();
                    String password = passwordCtrl.text.trim();
                    if (uname.isEmpty || password.isEmpty) {
                      String message = 'Form cant be empty';
                      if (uname.isEmpty && password.isNotEmpty) {
                        message = 'Username cant be empty';
                      } else if (uname.isNotEmpty && password.isEmpty) {
                        message = 'Password cant be empty';
                      }
                      Get.snackbar('Failed', message);
                    } else {
                      LoginModel data =
                          LoginModel(username: uname, password: password);
                      try {
                        var response = await apiCommand.postLogin(data);
                        if (response[0]['status'] == 'success') {
                          Get.to(const OrganismsBottomBar());
                          Get.snackbar('Success', response[0]['message']);
                        } else {
                          Get.snackbar('failed', response[0]['message']);
                        }
                      } catch (e) {
                        Get.snackbar('error', e.toString());
                      }
                    }
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.arrowRightToBracket,
                    color: whiteColor,
                    size: spaceXMD,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
