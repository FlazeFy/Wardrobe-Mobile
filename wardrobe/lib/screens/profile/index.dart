import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/profile/about/index.dart';
import 'package:wardrobe/screens/profile/export/index.dart';
import 'package:wardrobe/screens/profile/feedback/index.dart';
import 'package:wardrobe/screens/profile/sections/profile_all_history.dart';
import 'package:wardrobe/screens/profile/sections/profile_edit_form.dart';
import 'package:wardrobe/screens/profile/sections/profile_post_question.dart';
import 'package:wardrobe/screens/profile/sections/profile_sign_out.dart';
import 'package:wardrobe/screens/profile/sync/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  StateProfilePageState createState() => StateProfilePageState();
}

class StateProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              AtomsButton(
                type: "btn-primary",
                text: "Unsaved Data",
                icon: const FaIcon(FontAwesomeIcons.triangleExclamation,
                    color: whiteColor, size: textMD),
                action: () {
                  Get.to(const SyncPage());
                },
              ),
              const SizedBox(width: spaceMini),
              const ProfileSectionSignOut(),
              const SizedBox(width: spaceMini),
              AtomsButton(
                type: "btn-success",
                text: "Export My Data",
                icon: const FaIcon(FontAwesomeIcons.download,
                    color: whiteColor, size: textMD),
                action: () {
                  Get.to(const ExportMyDataPage());
                },
              ),
              const SizedBox(width: spaceMini),
              AtomsButton(
                type: "btn-primary",
                text: "Feedback",
                icon: const FaIcon(FontAwesomeIcons.solidComment,
                    color: whiteColor, size: textMD),
                action: () {
                  Get.to(const FeedbackPage());
                },
              ),
              const SizedBox(width: spaceMini),
              AtomsButton(
                type: "btn-primary",
                text: "About Us",
                icon: const FaIcon(FontAwesomeIcons.circleInfo,
                    color: whiteColor, size: textMD),
                action: () {
                  Get.to(const AboutUsPage());
                },
              ),
            ],
          ),
        ),
        const ProfileSectionEditForm(),
        const SizedBox(height: spaceMD),
        const ProfileSectionPostQuestion(),
        const ProfileSectionAllHistory()
      ],
    ));
  }
}
