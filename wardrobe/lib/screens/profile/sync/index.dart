import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/profile/sync/sections/sync_all_feedback.dart';
import 'package:wardrobe/screens/profile/sync/sections/sync_all_question.dart';
import 'package:wardrobe/screens/profile/sync/sections/sync_post_question.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({Key? key}) : super(key: key);

  @override
  StateSyncPageState createState() => StateSyncPageState();
}

class StateSyncPageState extends State<SyncPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Unsynchronized")),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceMD, vertical: spaceSM),
          children: [
            Container(
                padding: const EdgeInsets.all(spaceMD),
                margin: const EdgeInsets.only(bottom: spaceMD),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(roundedLG)),
                    border:
                        Border.all(width: spaceMini / 3, color: blackColor)),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AtomsText(
                              type: "content-title", text: "All Question"),
                          Spacer(),
                          SyncSectionPostQuestion()
                        ],
                      ),
                      SizedBox(height: spaceMD),
                      SyncSectionAllQuestion(),
                    ])),
            const SizedBox(height: spaceMD),
            Container(
                padding: const EdgeInsets.all(spaceMD),
                margin: const EdgeInsets.only(bottom: spaceMD),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(roundedLG)),
                    border:
                        Border.all(width: spaceMini / 3, color: blackColor)),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AtomsText(
                              type: "content-title", text: "All Feedback"),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: spaceMD),
                      SyncSectionAllFeedback()
                    ])),
          ],
        ));
  }
}
