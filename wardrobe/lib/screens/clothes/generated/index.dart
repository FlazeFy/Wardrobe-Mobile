import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/generated/sections/generated_outfit_monthly_total_used.dart';

class GeneratedPage extends StatefulWidget {
  const GeneratedPage({Key? key}) : super(key: key);

  @override
  StateGeneratedPageState createState() => StateGeneratedPageState();
}

class StateGeneratedPageState extends State<GeneratedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Generated Outfit Page")),
        body: ListView(
          padding: const EdgeInsets.all(spaceMD),
          children: const [GeneratedOutfitSectionMonthlyTotalUsed()],
        ));
  }
}
