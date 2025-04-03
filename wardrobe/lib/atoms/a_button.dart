import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';

class AtomsButton extends StatelessWidget {
  final String type;
  final String? text;
  final dynamic action;
  final dynamic icon;

  const AtomsButton(
      {super.key, required this.type, this.text, this.action, this.icon});

  @override
  Widget build(BuildContext context) {
    if (type == 'btn-success' ||
        type == 'btn-primary' ||
        type == 'btn-danger' ||
        type == 'btn-warning') {
      List<Color> gradientColors = (type == 'btn-success')
          ? [successDarkBG, successBG]
          : (type == 'btn-primary')
              ? [darkInfoBG, infoBG]
              : (type == 'btn-warning')
                  ? [warningDarkBG, warningBG]
                  : [dangerDarkBG, dangerBG];

      return InkWell(
          onTap: action,
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: spaceSM, horizontal: spaceMD),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              border: Border.all(width: spaceMini / 2, color: whiteColor),
              borderRadius:
                  const BorderRadius.all(Radius.circular(roundedJumbo)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Container(
                      margin: const EdgeInsets.only(right: spaceXXSM),
                      child: icon),
                ],
                Text(text ?? '',
                    style: const TextStyle(
                        color: whiteColor, fontWeight: FontWeight.w500)),
              ],
            ),
          ));
    } else if (type == 'btn-tag') {
      return Container(
        padding:
            const EdgeInsets.symmetric(vertical: spaceXSM, horizontal: spaceSM),
        decoration: const BoxDecoration(
          color: darkInfoBG,
          borderRadius: BorderRadius.all(Radius.circular(roundedJumbo)),
        ),
        child: text != null
            ? Text(
                text ?? '',
                style: const TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: textXMD),
              )
            : icon,
      );
    } else {
      return const Text("Default Title");
    }
  }
}
