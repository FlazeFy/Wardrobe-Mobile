import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/detail/generated/sections/generated_all_outfit.dart';

class DetailGeneratedOutfitPage extends StatefulWidget {
  const DetailGeneratedOutfitPage(
      {Key? key, required this.items, required this.clothesName})
      : super(key: key);
  final List<OutfitModel?> items;
  final String clothesName;

  @override
  StateUsedPageState createState() => StateUsedPageState();
}

class StateUsedPageState extends State<DetailGeneratedOutfitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Generated Outfit Page")),
        body: ListView(
          padding: const EdgeInsets.all(spaceMD),
          children: [
            AtomsText(
              type: "content-title",
              text: "Outfit : ${widget.clothesName}",
              color: blackColor,
            ),
            GeneratedOutfitSectionAllOutfit(items: widget.items)
          ],
        ));
  }
}
