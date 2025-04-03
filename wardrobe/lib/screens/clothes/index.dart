import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/clothes/sections/clothes_all_header.dart';
import 'package:wardrobe/screens/clothes/trash/index.dart';

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
      children: [
        Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AtomsText(type: "page-title", text: "All Clothes"),
                AtomsText(
                    type: "content-sub-title",
                    text: "For more detail you can see the"),
              ],
            ),
            const Spacer(),
            AtomsButton(
                type: "btn-danger",
                text: "Clothes",
                action: () {
                  Get.to(const TrashPage());
                },
                icon: const FaIcon(
                  FontAwesomeIcons.trash,
                  size: textMD,
                  color: whiteColor,
                ))
          ],
        ),
        const ClothesSectioAllHeader()
      ],
    ));
  }
}
