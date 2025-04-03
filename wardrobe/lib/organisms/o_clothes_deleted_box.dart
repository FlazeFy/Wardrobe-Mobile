import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class OrganismsClothesDeletedBox extends StatelessWidget {
  final ClothesDeletedModel item;

  const OrganismsClothesDeletedBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        margin: const EdgeInsets.only(bottom: spaceMD),
        decoration: const BoxDecoration(
            color: primaryLightBG,
            borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
        padding: const EdgeInsets.all(spaceSM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                AtomsText(
                    type: "content-title",
                    text: item.clothesName,
                    color: blackColor),
                const Spacer(),
                AtomsText(
                    type: "content-sub-title",
                    text:
                        "${getCleanTitleFromCtx(item.clothesCategory)} | ${getCleanTitleFromCtx(item.clothesType)}"),
              ],
            ),
            Row(
              children: [
                if (item.clothesSize != '-')
                  AtomsButton(type: 'btn-tag', text: item.clothesSize),
                if (item.clothesSize != '-') const SizedBox(width: spaceMini),
                AtomsButton(
                  type: 'btn-tag',
                  icon: FaIcon(
                    item.clothesGender == 'male'
                        ? FontAwesomeIcons.mars
                        : item.clothesGender == 'female'
                            ? FontAwesomeIcons.venus
                            : FontAwesomeIcons.marsAndVenus,
                    size: textLG,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(width: spaceMini),
              ],
            ),
            const SizedBox(height: spaceMD),
            item.clothesDesc != null
                ? AtomsText(type: "content-body", text: item.clothesDesc ?? '-')
                : const AtomsText(
                    type: "no-data",
                    text: 'No Description Provided',
                    color: darkColor),
            const SizedBox(height: spaceSM),
            Row(children: [
              AtomsText(
                  type: "content-sub-title",
                  text: "Color : ${item.clothesColor}"),
              const Spacer(),
              AtomsText(
                  type: "content-sub-title",
                  text:
                      "Deleted At : ${convertDatetimeBasedLocal(item.deletedAt)}"),
            ]),
            const SizedBox(height: spaceMD),
            const Row(
              children: [
                Expanded(
                    child: AtomsButton(
                        type: 'btn-danger',
                        text: 'Permanently Delete',
                        icon: FaIcon(
                          FontAwesomeIcons.fire,
                          size: textMD,
                          color: whiteColor,
                        ))),
                SizedBox(width: spaceSM),
                Expanded(
                    child: AtomsButton(
                  type: 'btn-success',
                  text: 'Recover Now!',
                  icon: FaIcon(
                    FontAwesomeIcons.rotateLeft,
                    size: textMD,
                    color: whiteColor,
                  ),
                ))
              ],
            )
          ],
        ));
  }
}
