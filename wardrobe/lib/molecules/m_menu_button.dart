import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class MoleculesMenuButton extends StatelessWidget {
  final String title;
  final String desc;
  final String urlImage;
  final dynamic action;

  const MoleculesMenuButton(
      {super.key,
      required this.title,
      required this.desc,
      required this.urlImage,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: action,
        child: Container(
          margin: const EdgeInsets.only(right: spaceMD),
          width: 240,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(urlImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(roundedLG),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.55),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(roundedLG),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(spaceSM),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AtomsText(type: "content-title-main", text: title),
                      AtomsText(type: "content-body", text: desc)
                    ],
                  )),
            ],
          ),
        ));
  }
}
