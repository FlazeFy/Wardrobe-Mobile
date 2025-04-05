import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class OrganismsWashBox extends StatelessWidget {
  final WashHistoryModel item;

  const OrganismsWashBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        margin: const EdgeInsets.only(bottom: spaceMD),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
            color: greyColor),
        padding: const EdgeInsets.all(spaceLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AtomsText(
              type: "content-title",
              text: item.clothesName,
              color: blackColor,
              marginBottom: spaceMini,
            ),
            Wrap(
              children: [
                AtomsButton(
                    type: "btn-tag",
                    text: ucFirstWord(item.clothesType),
                    color: infoBG),
                const SizedBox(width: spaceXXSM),
                item.clothesMerk != null
                    ? AtomsButton(
                        type: "btn-tag",
                        text: ucFirstWord(item.clothesMerk ?? "-"),
                        color: dangerBG)
                    : const SizedBox(),
                const SizedBox(width: spaceXXSM),
                AtomsButton(
                    type: "btn-tag",
                    text: ucFirstWord(item.clothesMadeFrom),
                    color: successBG)
              ],
            ),
            const SizedBox(height: spaceMD),
            item.washNote != null
                ? AtomsText(
                    type: "content-body",
                    text: "${item.washNote}",
                    color: blackColor)
                : const AtomsText(type: "no-data", text: "No Notes Provided"),
            const SizedBox(height: spaceSM),
            AtomsText(
                type: "content-sub-title",
                text:
                    "${item.washType} | ${convertDatetimeBasedLocal(item.washAt)}",
                color: blackColor),
            const Divider(color: blackColor),
            const AtomsText(
                type: "content-sub-title",
                text: "Checkpoint",
                color: blackColor),
            Column(
                children: item.washCheckpoint
                    .map((dt) => AtomsText(
                          text:
                              "${dt.isFinished ? "✅" : "❌"} ${dt.checkpointName}",
                          type: "content-body",
                          color: blackColor,
                        ))
                    .toList()),
            const SizedBox(height: spaceSM),
            const Row(
              children: [
                AtomsButton(
                  type: "btn-primary",
                  text: "Wash Again",
                  icon: FaIcon(
                    FontAwesomeIcons.rotateLeft,
                    color: whiteColor,
                    size: textMD,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    AtomsButton(
                      type: "btn-icon",
                      color: warningBG,
                      icon: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        color: whiteColor,
                        size: textXLG,
                      ),
                    ),
                    SizedBox(width: spaceXSM),
                    AtomsButton(
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
            )
          ],
        ));
  }
}
