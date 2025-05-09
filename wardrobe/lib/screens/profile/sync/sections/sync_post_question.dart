import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/service/commands.dart';
import 'package:wardrobe/screens/profile/sync/index.dart';

class SyncSectionPostQuestion extends StatefulWidget {
  const SyncSectionPostQuestion({super.key});

  @override
  StateSyncSectionPostQuestion createState() => StateSyncSectionPostQuestion();
}

class StateSyncSectionPostQuestion extends State<SyncSectionPostQuestion> {
  late QuestionCommandsService apiCommand;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiCommand = QuestionCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return AtomsButton(
      type: "btn-success",
      text: "Sync All Question",
      icon: const FaIcon(FontAwesomeIcons.rotateLeft,
          size: textMD, color: whiteColor),
      action: () async {
        apiCommand.syncQuestions().then((response) {
          Get.to(const SyncPage());
        });
      },
    );
  }
}
