import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/auth/service/queries.dart';
import 'package:wardrobe/screens/landing/index.dart';

class ProfileSectionSignOut extends StatefulWidget {
  const ProfileSectionSignOut({super.key});

  @override
  StateProfileSectionSignOut createState() => StateProfileSectionSignOut();
}

class StateProfileSectionSignOut extends State<ProfileSectionSignOut> {
  late AuthQueriesService apiQuery;

  @override
  void initState() {
    super.initState();
    apiQuery = AuthQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return AtomsButton(
      type: "btn-danger",
      text: "Sign Out",
      icon: const FaIcon(FontAwesomeIcons.arrowRightToBracket,
          color: whiteColor, size: textMD),
      action: () {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                showCancelBtn: true,
                onCancel: () {
                  Get.back();
                },
                onConfirm: () async {
                  try {
                    var response = await apiQuery.getSignOut();
                    if (response[0]['status'] == 'success') {
                      Get.to(const LoginPage());
                      Get.snackbar('Success', response[0]['message']);
                    } else {
                      Get.to(const LoginPage());
                      Get.snackbar('failed', response[0]['message']);
                    }
                  } catch (e) {
                    Get.snackbar('error', 'something went wrong');
                  }
                },
                type: ArtSweetAlertType.question,
                title: "Are you sure?",
                text: "Want to sign out from this account?"));
      },
    );
  }
}
