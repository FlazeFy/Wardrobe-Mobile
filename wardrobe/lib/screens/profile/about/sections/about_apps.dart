import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class AboutSectionApps extends StatefulWidget {
  const AboutSectionApps({super.key});

  @override
  State<AboutSectionApps> createState() => _AboutSectionAppsState();
}

class _AboutSectionAppsState extends State<AboutSectionApps> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(spaceLG),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [infoBG, primaryLightBG],
          ),
          border: Border.all(width: spaceMini / 2, color: whiteColor),
          borderRadius: const BorderRadius.all(Radius.circular(roundedJumbo)),
        ),
        child: const Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AtomsText(
                  type: "content-title-main",
                  text: "About",
                  color: blackColor,
                ),
                SizedBox(width: spaceSM),
                AtomsText(
                  type: "content-title-main",
                  text: "Wardrobe",
                ),
              ],
            ),
            AtomsText(
              type: "content-sub-title",
              text:
                  "Wardrobe is your ultimate clothing assistant, helping you organize outfits, track history, manage schedules, and plan weekly looks. Unsure what to wear? Our smart outfit randomizer suggests perfect options based on availability and favorites. Join us and we will keeps your style decision effortless and organize.",
              color: blackColor,
              align: TextAlign.center,
            ),
          ],
        ));
  }
}
