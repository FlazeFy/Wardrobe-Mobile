import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class MoleculesTopBar extends StatelessWidget {
  final String title;

  const MoleculesTopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: greyColor,
        border: Border(
          bottom: BorderSide(color: blackColor, width: spaceMini / 2),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AtomsText(
          text: title,
          type: "appbar-text",
        ),
        leading: Padding(
          padding: const EdgeInsets.all(spaceXXSM),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(spaceSM),
              margin: const EdgeInsets.only(left: spaceMini),
              decoration: BoxDecoration(
                color: dangerBG,
                border: Border.all(color: whiteColor, width: 2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.2),
                    blurRadius: spaceSM,
                    spreadRadius: 0.0,
                    offset: const Offset(
                      spaceMini,
                      spaceMini,
                    ),
                  )
                ],
              ),
              child: const FaIcon(FontAwesomeIcons.arrowLeft,
                  color: whiteColor, size: textXLG),
            ),
          ),
        ),
      ),
    );
  }
}
