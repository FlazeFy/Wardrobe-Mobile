import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/profile/sections/profile_post_question.dart';
import 'package:wardrobe/screens/sync/index.dart';

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
      padding: EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: [
        Row(
          children: [
            AtomsButton(
              type: "btn-primary",
              text: "Unsaved Data",
              action: () {
                Get.to(const SyncPage());
              },
            )
          ],
        ),
        SizedBox(height: spaceMD),
        ProfileSectionPostQuestion()
      ],
    ));
  }
}
