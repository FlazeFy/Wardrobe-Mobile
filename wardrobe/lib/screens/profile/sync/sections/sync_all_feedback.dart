import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/feedback/model/commands.dart';
import 'package:wardrobe/modules/sqlite/init.dart';
import 'package:wardrobe/molecules/m_feedback_box.dart';

class SyncSectionAllFeedback extends StatefulWidget {
  const SyncSectionAllFeedback({super.key});

  @override
  StateSyncSectionAllFeedback createState() => StateSyncSectionAllFeedback();
}

class StateSyncSectionAllFeedback extends State<SyncSectionAllFeedback> {
  late DatabaseHelper dbHelper;
  List<FeedbackModel> unsyncedFeedbacks = [];
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

    var feedbackData = await dbHelper.getUnsyncedFeedback();

    setState(() {
      unsyncedFeedbacks = feedbackData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildQuestionsColumn(unsyncedFeedbacks),
    );
  }

  Widget _buildQuestionsColumn(List<FeedbackModel> feedbacks) {
    if (feedbacks.isNotEmpty) {
      return Column(
        children: feedbacks.map((dt) {
          return MoleculesFeedbackBox(item: dt);
        }).toList(),
      );
    } else {
      return const Center(child: Text("No unsynchronized feedbacks found."));
    }
  }
}
