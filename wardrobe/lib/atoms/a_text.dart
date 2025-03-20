import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';

class AtomsText extends StatelessWidget {
  final String type;
  final String text;
  final TextAlign? align;
  final Color? color;
  final FontStyle? fstyle;

  const AtomsText(
      {super.key,
      required this.type,
      required this.text,
      this.align,
      this.color,
      this.fstyle});

  @override
  Widget build(BuildContext context) {
    if (type == 'table-text') {
      return Text(text, style: const TextStyle(fontSize: textMD));
    } else if (type == 'appbar-text') {
      return Text(text,
          style: const TextStyle(
              fontSize: textLG,
              fontWeight: FontWeight.bold,
              color: whiteColor));
    } else if (type == 'page-title') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceMD),
          child: Text(text,
              textAlign: align ?? TextAlign.start,
              style: TextStyle(
                  color: color ?? darkColor,
                  fontSize: textJumbo,
                  fontWeight: FontWeight.w700)));
    } else if (type == 'content-title') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceSM),
          child: Text(text,
              style: const TextStyle(
                  fontSize: textLG, fontWeight: FontWeight.w600)));
    } else if (type == 'content-sub-title') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style: TextStyle(
                  color: color ?? darkColor,
                  fontSize: textMD,
                  fontWeight: FontWeight.w500)));
    } else if (type == 'content-body') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              textAlign: align ?? TextAlign.start,
              style: TextStyle(
                  fontSize: textMD,
                  fontStyle: fstyle ?? FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: color ?? whiteColor)));
    } else if (type == 'no-data') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceMini),
          child: Text("- $text -",
              style: const TextStyle(
                  fontSize: textMD,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  color: greyColor)));
    } else {
      return const Text("Default Title");
    }
  }
}
