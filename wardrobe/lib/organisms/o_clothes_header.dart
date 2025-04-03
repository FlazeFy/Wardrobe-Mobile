import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class OrganismsClothesHeader extends StatelessWidget {
  final ClothesHeaderAllModel item;

  const OrganismsClothesHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        margin: const EdgeInsets.only(bottom: spaceMD),
        decoration: const BoxDecoration(
            color: primaryLightBG,
            borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
        padding: const EdgeInsets.all(spaceSM),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: spaceMD),
              decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(roundedLG)),
              width: Get.width * 0.35,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(roundedJumbo + roundedJumbo),
                child: Image.asset('assets/images/footwear.png',
                    width: Get.width * 0.5),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AtomsText(
                    type: "content-title",
                    text: item.clothesName,
                    color: blackColor),
                AtomsText(
                    type: "content-sub-title",
                    text:
                        "${getCleanTitleFromCtx(item.clothesCategory)} | ${getCleanTitleFromCtx(item.clothesType)}"),
                const SizedBox(height: spaceMD),
                Row(
                  children: [
                    if (item.clothesSize != '-')
                      AtomsButton(type: 'btn-tag', text: item.clothesSize),
                    if (item.clothesSize != '-')
                      const SizedBox(width: spaceMini),
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
                    if (item.isFavorite == 1) ...[
                      AtomsButton(
                        type: 'btn-tag',
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              roundedJumbo + roundedJumbo),
                          child: Image.asset('assets/images/favorite.png',
                              width: spaceLG - 2),
                        ),
                      ),
                      const SizedBox(width: spaceMini),
                    ],
                    if (item.isScheduled == 1) ...[
                      AtomsButton(
                        type: 'btn-tag',
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              roundedJumbo + roundedJumbo),
                          child: Image.asset('assets/images/scheduled.png',
                              width: spaceLG - 2),
                        ),
                      ),
                      const SizedBox(width: spaceMini),
                    ],
                    if (item.hasWashed == 1) ...[
                      AtomsButton(
                        type: 'btn-tag',
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              roundedJumbo + roundedJumbo),
                          child: Image.asset('assets/images/dry.png',
                              width: spaceLG - 2),
                        ),
                      ),
                      const SizedBox(width: spaceMini),
                    ],
                    if (item.hasIroned == 1) ...[
                      AtomsButton(
                        type: 'btn-tag',
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              roundedJumbo + roundedJumbo),
                          child: Image.asset('assets/images/ironed.png',
                              width: spaceLG - 2),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: spaceMD),
                const Row(
                  children: [
                    AtomsButton(
                        type: 'btn-success',
                        text: 'Use It Now!',
                        icon: FaIcon(
                          FontAwesomeIcons.plus,
                          size: textMD,
                          color: whiteColor,
                        )),
                    SizedBox(width: spaceXXSM),
                    AtomsButton(
                      type: 'btn-primary',
                      text: 'Detail',
                      icon: FaIcon(
                        FontAwesomeIcons.arrowRight,
                        size: textMD,
                        color: whiteColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
