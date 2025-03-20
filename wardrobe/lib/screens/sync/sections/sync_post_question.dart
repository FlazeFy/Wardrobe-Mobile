import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/model/commands.dart';
import 'package:wardrobe/modules/api/question/service/commands.dart';
import 'package:wardrobe/modules/sqlite/init.dart';
import 'package:wardrobe/molecules/m_question_box.dart';

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
      action: () async {
        apiCommand.syncQuestions().then((response) {
          setState(() => {});
        });
      },
    );
  }
}
