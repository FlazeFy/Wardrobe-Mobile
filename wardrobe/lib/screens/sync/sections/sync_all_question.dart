import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/model/commands.dart';
import 'package:wardrobe/modules/sqlite/init.dart';
import 'package:wardrobe/molecules/m_question_box.dart';

class SyncSectionAllQuestion extends StatefulWidget {
  const SyncSectionAllQuestion({super.key});

  @override
  StateSyncSectionAllQuestion createState() => StateSyncSectionAllQuestion();
}

class StateSyncSectionAllQuestion extends State<SyncSectionAllQuestion> {
  late DatabaseHelper dbHelper;
  List<AskQuestionModel> unsyncedQuestions = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    var questionsData = await dbHelper.getUnsyncedQuestion();

    setState(() {
      unsyncedQuestions = questionsData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildQuestionsColumn(unsyncedQuestions),
    );
  }

  Widget _buildQuestionsColumn(List<AskQuestionModel> questions) {
    if (questions.isNotEmpty) {
      return Column(
        children: questions.map((dt) {
          return MoleculesQuestionBox(item: dt);
        }).toList(),
      );
    } else {
      return const Center(child: Text("No unsynchronized questions found."));
    }
  }
}
