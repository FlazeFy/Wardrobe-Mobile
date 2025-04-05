import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class LandingSectionFooter extends StatefulWidget {
  const LandingSectionFooter({super.key});

  @override
  State<LandingSectionFooter> createState() => _LandingSectionFooterState();
}

class _LandingSectionFooterState extends State<LandingSectionFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(spaceMD),
        decoration: BoxDecoration(
            color: primaryColor,
            border: Border.all(color: blackColor, width: spaceMini / 2),
            borderRadius: const BorderRadius.all(Radius.circular(roundedXLG))),
        child: const Column(
          children: [
            AtomsText(
              type: "content-title-main",
              text: "Wardrobe",
              align: TextAlign.center,
            ),
            AtomsText(
              type: "content-sub-title",
              text: "- Effortless style decision and Organize -",
              color: blackColor,
              align: TextAlign.center,
            ),
            Divider(
              color: blackColor,
              height: spaceLG,
            ),
            AtomsText(
              type: "content-body",
              text: "flazen.edu@gmail.com | https://github.com/FlazeFy",
              color: blackColor,
              align: TextAlign.center,
            ),
            SizedBox(height: spaceMD),
            AtomsText(
              type: "content-body",
              text: "© 2024 Part Of FlazenApps",
              color: blackColor,
              align: TextAlign.center,
            ),
          ],
        ));
  }
}
