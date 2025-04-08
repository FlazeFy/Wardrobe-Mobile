import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class OrganismsUsedClothesBox extends StatelessWidget {
  final UsedHistoryModel item;

  const OrganismsUsedClothesBox({super.key, required this.item});

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
            Row(
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
            ),
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
                const AtomsButton(
                  type: "btn-icon",
                  color: dangerBG,
                  icon: FaIcon(
                    FontAwesomeIcons.trash,
                    color: whiteColor,
                    size: textXLG,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
