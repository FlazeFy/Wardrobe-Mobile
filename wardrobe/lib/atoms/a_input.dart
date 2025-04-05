import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class AtomsInput extends StatelessWidget {
  final String type;
  final String? label;
  final dynamic action;
  final dynamic controller;
  final Color? color;
  final String? keyName;
  final int? lines;
  final double? minRating;
  final int? maxRating;

  const AtomsInput(
      {super.key,
      required this.type,
      this.label,
      this.action,
      this.color,
      this.controller,
      this.keyName,
      this.lines,
      this.minRating,
      this.maxRating});

  @override
  Widget build(BuildContext context) {
    if (type == 'input-text') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceSM),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            label != null
                ? AtomsText(
                    type: "input-label",
                    text: "$label",
                    color: color ?? whiteColor)
                : const SizedBox(),
            TextFormField(
              controller: controller,
              key: Key(keyName ?? '-'),
              maxLines: null,
              minLines: lines ?? 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: spaceMini, horizontal: spaceSM),
                fillColor: whiteColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: darkColor,
                    width: 1.25,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: darkColor,
                    width: 1.25,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: darkColor,
                    width: 1.25,
                  ),
                ),
              ),
            )
          ]));
    } else if (type == 'rating') {
      return ValueListenableBuilder<double>(
        valueListenable: controller,
        builder: (context, value, _) {
          return RatingBar.builder(
            initialRating: value,
            minRating: minRating ?? 1.0,
            direction: Axis.horizontal,
            itemSize: textJumbo - textMini / 2,
            allowHalfRating: true,
            itemCount: maxRating ?? 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const FaIcon(
              FontAwesomeIcons.solidStar,
              color: warningBG,
            ),
            onRatingUpdate: (rating) {
              controller!.value = rating;
            },
          );
        },
      );
    } else {
      return const Text("Default Title");
    }
  }
}
