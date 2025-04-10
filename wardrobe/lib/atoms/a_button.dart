import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class AtomsButton extends StatelessWidget {
  final String type;
  final String? text;
  final dynamic action;
  final dynamic icon;
  final Color? color;
  final bool? isDisabled;

  const AtomsButton(
      {super.key,
      required this.type,
      this.text,
      this.action,
      this.icon,
      this.color,
      this.isDisabled});

  @override
  Widget build(BuildContext context) {
    if (type == 'btn-success' ||
        type == 'btn-primary' ||
        type == 'btn-danger' ||
        type == 'btn-warning') {
      List<Color> baseColors = (type == 'btn-success')
          ? [successDarkBG, successBG]
          : (type == 'btn-primary')
              ? [darkInfoBG, infoBG]
              : (type == 'btn-warning')
                  ? [warningDarkBG, warningBG]
                  : [dangerDarkBG, dangerBG];

      List<Color> gradientColors = isDisabled == true
          ? baseColors.map((c) => c.withOpacity(0.5)).toList()
          : baseColors;

      return InkWell(
          onTap: isDisabled == true ? () {} : action,
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
                Text(ucFirstWord(text ?? ''),
                    style: const TextStyle(
                        color: whiteColor, fontWeight: FontWeight.w500)),
              ],
            ),
          ));
    } else if (type == 'btn-tag') {
      return Container(
        padding:
            const EdgeInsets.symmetric(vertical: spaceXSM, horizontal: spaceSM),
        decoration: BoxDecoration(
          color: color ?? darkInfoBG,
          borderRadius: const BorderRadius.all(Radius.circular(roundedJumbo)),
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
    } else if (type == 'btn-icon') {
      return InkWell(
        onTap: isDisabled == true ? () {} : action,
        child: Container(
          width: 46,
          height: 46,
          padding: const EdgeInsets.all(spaceMD - 1),
          decoration: BoxDecoration(
            color: color ?? infoBG,
            border: Border.all(width: spaceMini / 2, color: whiteColor),
            borderRadius: BorderRadius.circular(roundedCircle),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.35),
                blurRadius: spaceLG,
                spreadRadius: 0.0,
                offset: const Offset(
                  spaceMini,
                  spaceMini,
                ),
              )
            ],
          ),
          child: icon,
        ),
      );
    } else {
      return const Text("Default Title");
    }
  }
}
