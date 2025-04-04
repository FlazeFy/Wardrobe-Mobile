import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_features_box.dart';

class LandingSectionFeatures extends StatefulWidget {
  const LandingSectionFeatures({super.key});

  @override
  State<LandingSectionFeatures> createState() => _LandingSectionFeaturesState();
}

class _LandingSectionFeaturesState extends State<LandingSectionFeatures> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const AtomsText(
          type: "content-title",
          text:
              "From Store Your Clothes Information Until Deciding What You Should Wear Tommorow!",
          color: blackColor,
          align: TextAlign.end,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: spaceMD),
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              MoleculesFeaturesBox(
                icon: FaIcon(
                  FontAwesomeIcons.shirt,
                  color: whiteColor,
                  size: textXLG,
                ),
                title: "Store Clothes Information",
                body:
                    "Keep track of your wardrobe by listing each item with its name, type, category, size, price, brand, and color. Add tags to make outfit selection easier and smarter!",
              ),
              MoleculesFeaturesBox(
                icon: FaIcon(
                  FontAwesomeIcons.personDress,
                  color: whiteColor,
                  size: textXLG + textMini / 2.5,
                ),
                title: "Customize Your Outfit",
                body:
                    "Organize your clothes by type like hats, shirts, pants, and shoes. Mix and match by color, style, or any way you like to create the perfect outfit!",
              ),
              MoleculesFeaturesBox(
                icon: FaIcon(
                  FontAwesomeIcons.dice,
                  color: whiteColor,
                  size: textXLG,
                ),
                title: "Outfit Generator!",
                body:
                    "Let our smart algorithm suggest the best outfit for you! Based on your stored clothes, wash schedule, and usage history, we’ll help you dress effortlessly.",
              ),
              MoleculesFeaturesBox(
                icon: FaIcon(
                  FontAwesomeIcons.calendar,
                  color: whiteColor,
                  size: textXLG,
                ),
                title: "Wash & Wear Scheduling",
                body:
                    "Plan your laundry days, track when you last wore each item, and ensure all your clothes get equal love. Use our calendar to stay organized!",
              ),
              MoleculesFeaturesBox(
                icon: FaIcon(
                  FontAwesomeIcons.chartPie,
                  color: whiteColor,
                  size: textXLG,
                ),
                title: "Analyze Your Wardrobe",
                body:
                    "Curious about your most-worn outfits? Want to rediscover forgotten pieces? Our analytics visualize your wardrobe habits in insightful ways.",
              ),
              MoleculesFeaturesBox(
                icon: FaIcon(
                  FontAwesomeIcons.table,
                  color: whiteColor,
                  size: textXLG,
                ),
                title: "Export & Manage Your Data",
                body:
                    "View and export your clothing data in different formats like Excel or PDF. Prefer manual management? Easily edit your wardrobe outside the app!",
              ),
            ],
          ),
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AtomsText(
              type: "content-title-main",
              text: "Our",
              color: blackColor,
            ),
            SizedBox(width: spaceXSM),
            AtomsText(
                type: "content-title-main",
                text: "Capabilities",
                color: infoBG),
          ],
        ),
        const AtomsText(
          type: "content-title",
          text: "Want to Know How Our Apps Works?",
          color: blackColor,
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AtomsButton(
              type: "btn-success",
              text: "See More!",
              icon: FaIcon(FontAwesomeIcons.arrowRight,
                  size: textXMD, color: whiteColor),
            ),
            SizedBox(width: spaceMini),
            AtomsButton(
              type: "btn-primary",
              text: "Get The Manual",
              icon: FaIcon(FontAwesomeIcons.solidCircleQuestion,
                  size: textXMD, color: whiteColor),
            )
          ],
        )
      ],
    );
  }
}
