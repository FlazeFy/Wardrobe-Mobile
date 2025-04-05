import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class LandingSectionPlatform extends StatefulWidget {
  const LandingSectionPlatform({super.key});

  @override
  State<LandingSectionPlatform> createState() => _LandingSectionPlatformState();
}

class _LandingSectionPlatformState extends State<LandingSectionPlatform> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AtomsText(
          type: "content-title",
          text:
              "Wardrobe Can Be Used From Web Apps, Mobile Apps, and Telegram BOT",
          color: blackColor,
          align: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AtomsText(
              type: "content-title-main",
              text: "We're",
              color: blackColor,
              align: TextAlign.center,
            ),
            SizedBox(width: spaceSM),
            AtomsText(
              type: "content-title-main",
              text: "MultiPlatform",
              color: infoBG,
              align: TextAlign.center,
            ),
          ],
        ),
        AtomsText(
          type: "content-title",
          text:
              "Don't Worry, Almost All Of Our Feature Can Be Used Across All Platform",
          color: blackColor,
          align: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AtomsButton(
              type: "btn-success",
              text: "Web Version",
              icon: FaIcon(FontAwesomeIcons.globe,
                  size: textXMD, color: whiteColor),
            ),
            SizedBox(width: spaceMini),
            AtomsButton(
              type: "btn-primary",
              text: "Telegram BOT",
              icon: FaIcon(FontAwesomeIcons.solidPaperPlane,
                  size: textXMD, color: whiteColor),
            )
          ],
        )
      ],
    );
  }
}
