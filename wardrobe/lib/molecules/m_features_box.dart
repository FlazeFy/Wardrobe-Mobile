import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class MoleculesFeaturesBox extends StatelessWidget {
  final String title;
  final String body;
  final FaIcon icon;

  const MoleculesFeaturesBox(
      {super.key, required this.title, required this.body, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        padding: const EdgeInsets.all(spaceSM),
        margin: const EdgeInsets.only(right: spaceSM),
        decoration: BoxDecoration(
            border: Border.all(color: darkColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(roundedMD))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                margin: const EdgeInsets.only(bottom: spaceMD),
                padding: const EdgeInsets.all(spaceMD),
                decoration: const BoxDecoration(
                    color: infoBG,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: icon,
              ),
              AtomsText(
                type: "content-title",
                text: title,
                color: blackColor,
                marginBottom: 0,
                align: TextAlign.center,
              ),
              AtomsText(
                  type: "content-body",
                  text: body,
                  color: blackColor,
                  marginBottom: 0,
                  align: TextAlign.center),
            ]));
  }
}
