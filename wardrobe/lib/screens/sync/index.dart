import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/sync/sections/sync_all_question.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({Key? key}) : super(key: key);

  @override
  StateSyncPageState createState() => StateSyncPageState();
}

class StateSyncPageState extends State<SyncPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: infoBG,
            title: const AtomsText(
              text: "Unsynchronized",
              type: "appbar-text",
            )),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceMD, vertical: spaceSM),
          children: const [
            Row(
              children: [
                AtomsText(type: "page-title", text: "All Question"),
              ],
            ),
            SyncSectionAllQuestion()
          ],
        ));
  }
}
