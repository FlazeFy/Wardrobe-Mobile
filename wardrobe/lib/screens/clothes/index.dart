import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_menu_button.dart';
import 'package:wardrobe/screens/clothes/sections/clothes_all_header.dart';
import 'package:wardrobe/screens/clothes/trash/index.dart';
import 'package:wardrobe/screens/clothes/wash/index.dart';

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
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MoleculesMenuButton(
                title: "Add Clothes",
                desc:
                    "You have a new clothes? and want to monitoring or set schedule on it? Add to Wardrobe Now!",
                urlImage: "assets/images/add_clothes_menu.jpg",
                action: () {
                  //
                },
              ),
              MoleculesMenuButton(
                  title: "Wash History",
                  desc:
                      "See past wash history, on-going wash, or plan for the next days",
                  urlImage: "assets/images/wash_menu.jpg",
                  action: () {
                    Get.to(const WashPage());
                  }),
            ],
          ),
        ),
        const SizedBox(height: spaceMD),
        Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AtomsText(
                  type: "content-title",
                  text: "All Clothes",
                  color: blackColor,
                ),
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
