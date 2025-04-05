import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/feedback/service/commands.dart';
import 'package:wardrobe/screens/profile/sync/index.dart';

class SyncSectionPostFeedback extends StatefulWidget {
  const SyncSectionPostFeedback({super.key});

  @override
  StateSyncSectionPostFeedback createState() => StateSyncSectionPostFeedback();
}

class StateSyncSectionPostFeedback extends State<SyncSectionPostFeedback> {
  late FeedbackCommandsService apiCommand;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiCommand = FeedbackCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return AtomsButton(
      type: "btn-success",
      text: "Sync All Feedback",
      icon: const FaIcon(FontAwesomeIcons.rotateLeft,
          size: textMD, color: whiteColor),
      action: () async {
        apiCommand.syncFeedbacks().then((response) {
          Get.to(const SyncPage());
        });
      },
    );
  }
}
