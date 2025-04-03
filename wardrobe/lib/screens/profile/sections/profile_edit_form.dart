import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_input.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/user/model/queries.dart';
import 'package:wardrobe/modules/api/user/service/queries.dart';
import 'package:wardrobe/screens/profile/sections/profile_props_profile.dart';

class ProfileSectionEditForm extends StatefulWidget {
  const ProfileSectionEditForm({super.key});

  @override
  State<ProfileSectionEditForm> createState() => _ProfileSectionEditFormState();
}

class _ProfileSectionEditFormState extends State<ProfileSectionEditForm> {
  UserQueriesService? apiService;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController telegramUserIdCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService = UserQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getMyProfile(),
        builder:
            (BuildContext context, AsyncSnapshot<MyProfileModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            MyProfileModel? content = snapshot.data;

            return _buildListView(content);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(MyProfileModel? data) {
    usernameCtrl.text = data != null ? data.username : "";
    emailCtrl.text = data != null ? data.email : "";
    telegramUserIdCtrl.text = data != null ? data.telegramUserId ?? "" : "";

    return Column(children: [
      ProfileSectionPropsProfile(
          createdAt: data != null ? data.createdAt : "",
          updatedAt: data?.updatedAt),
      const SizedBox(height: spaceLG),
      Container(
        decoration: const BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
        padding: const EdgeInsets.all(spaceXMD),
        margin: const EdgeInsets.only(bottom: spaceMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AtomsText(
              type: "content-title",
              text: "Edit Profile",
              color: blackColor,
            ),
            AtomsInput(
                type: "input-text",
                label: "Username",
                color: darkColor,
                controller: usernameCtrl),
            AtomsInput(
                type: "input-text",
                label: "Email",
                color: darkColor,
                controller: emailCtrl),
            AtomsInput(
              type: "input-text",
              label: "Telegram User ID",
              color: darkColor,
              controller: telegramUserIdCtrl,
            ),
          ],
        ),
      )
    ]);
  }
}
