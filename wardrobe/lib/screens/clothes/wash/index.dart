import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/wash/sections/wash_all_history.dart';
import 'package:wardrobe/screens/clothes/wash/sections/wash_summary.dart';

class WashPage extends StatefulWidget {
  const WashPage({Key? key}) : super(key: key);

  @override
  StateWashPageState createState() => StateWashPageState();
}

class StateWashPageState extends State<WashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Wash Page")),
        body: ListView(
          padding: const EdgeInsets.all(spaceMD),
          children: const [
            WashSectionSummary(),
            SizedBox(height: spaceLG),
            AtomsText(
                type: "content-title-main",
                text: "History Of Wash",
                color: blackColor),
            WashSectionAllHistory()
          ],
        ));
  }
}
