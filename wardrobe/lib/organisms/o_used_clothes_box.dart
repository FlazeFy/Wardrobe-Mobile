import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/helpers/converter.dart';
import 'package:wardrobe/screens/clothes/used/sections/used_hard_delete_used_history.dart';

class OrganismsUsedClothesBox extends StatelessWidget {
  final String source;
  final dynamic item;

  const OrganismsUsedClothesBox(
      {super.key, required this.item, required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        margin: const EdgeInsets.only(bottom: spaceMD),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
            color: greyColor),
        padding: const EdgeInsets.all(spaceXMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            source == "all_history"
                ? Row(
                    children: [
                      AtomsText(
                        type: "content-title",
                        text: item.clothesName,
                        color: blackColor,
                        marginBottom: spaceMini,
                      ),
                      const Spacer(),
                      AtomsButton(
                        type: "btn-tag",
                        text: ucFirstWord(item.clothesType),
                      ),
                    ],
                  )
                : const SizedBox(),
            item.clothesNote != null
                ? AtomsText(
                    type: "content-sub-title",
                    text: item.clothesNote ?? "-",
                    color: blackColor,
                    marginBottom: spaceMini,
                  )
                : const AtomsText(
                    type: "no-data",
                    text: "No Notes Provided",
                    color: shadowColor),
            const SizedBox(height: spaceSM),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AtomsText(
                      type: "content-body",
                      text: "Context of Use : ${item.usedContext}",
                      color: blackColor,
                      marginBottom: spaceMini,
                    ),
                    AtomsText(
                      type: "content-body",
                      text:
                          "Used at : ${convertDatetimeBasedLocal(item.createdAt)}",
                      color: blackColor,
                      marginBottom: 0,
                    ),
                  ],
                ),
                const Spacer(),
                UsedSectionHardDeleteUsedHistory(id: item.id)
              ],
            )
          ],
        ));
  }
}
