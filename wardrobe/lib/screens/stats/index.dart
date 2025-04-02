import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/stats/sections/stats_monthly_clothes.dart';
import 'package:wardrobe/screens/stats/sections/stats_most_clothes_ctx.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  StateStatsPageState createState() => StateStatsPageState();
}

class StateStatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: const [
        AtomsText(type: "page-title", text: "Most Used Clothes"),
        AtomsText(
            type: "content-sub-title",
            text:
                "We analyze the most used clothes by its type, merk, size, colors, category, and type. The data is presented using Pie Chart and are limited to the 7 most used in each context"),
        StatsSectionMostClothesCtx(),
        StatsSectionMonthlyClothes()
      ],
    ));
  }
}
