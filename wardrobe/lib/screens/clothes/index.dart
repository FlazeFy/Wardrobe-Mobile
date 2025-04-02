import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/clothes/sections/clothes_all_header.dart';

class ClothesPage extends StatefulWidget {
  const ClothesPage({Key? key}) : super(key: key);

  @override
  StateClothesPageState createState() => StateClothesPageState();
}

class StateClothesPageState extends State<ClothesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: const [
        AtomsText(type: "page-title", text: "All Clothes"),
        AtomsText(
            type: "content-sub-title", text: "For more detail you can see the"),
        ClothesSectioAllHeader()
      ],
    ));
  }
}
