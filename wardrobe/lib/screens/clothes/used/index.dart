import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/used/sections/used_all_history.dart';
import 'package:wardrobe/screens/clothes/used/sections/used_monthly_clothes_used.dart';

class UsedPage extends StatefulWidget {
  const UsedPage({Key? key}) : super(key: key);

  @override
  StateUsedPageState createState() => StateUsedPageState();
}

class StateUsedPageState extends State<UsedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Used History Page")),
        body: ListView(
          padding: const EdgeInsets.all(spaceMD),
          children: const [
            UsedSectionMonthlyClothesUsed(),
            AtomsText(
              type: "content-title",
              text: "History Of Used",
              color: blackColor,
            ),
            UsedSectionAllHistory()
          ],
        ));
  }
}
