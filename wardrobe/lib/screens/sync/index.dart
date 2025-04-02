import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/sync/sections/sync_all_question.dart';
import 'package:wardrobe/screens/sync/sections/sync_post_question.dart';

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
          children: const [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AtomsText(type: "page-title", text: "All Question"),
                Spacer(),
                SyncSectionPostQuestion()
              ],
            ),
            SizedBox(height: spaceMD),
            SyncSectionAllQuestion()
          ],
        ));
  }
}
