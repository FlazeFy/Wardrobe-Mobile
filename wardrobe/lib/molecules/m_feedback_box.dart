import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/feedback/model/queries.dart';

class MoleculesFeedbackBox extends StatelessWidget {
  final TopFeedbackModel? item;

  const MoleculesFeedbackBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(spaceSM),
        margin: const EdgeInsets.only(right: spaceSM),
        decoration: BoxDecoration(
            border: Border.all(color: darkColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(roundedMD))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AtomsText(
                type: "content-title-main",
                text: "⭐️${item?.feedbackRate}",
                color: blackColor,
                marginBottom: 0),
            const SizedBox(width: spaceSM),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: spaceMini),
                AtomsText(
                    type: "content-title",
                    text: "${item?.feedbackBody}",
                    color: darkColor,
                    marginBottom: 0),
              ],
            )
          ],
        ));
  }
}
