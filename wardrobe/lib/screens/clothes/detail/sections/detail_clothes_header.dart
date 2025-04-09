import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class DetailSectionClothesHeader extends StatelessWidget {
  final String clothesCategory;
  final String clothesType;
  final String clothesSize;
  final String id;
  final String clothesName;
  final String? clothesDesc;
  final String? clothesImage;

  const DetailSectionClothesHeader(
      {super.key,
      required this.clothesCategory,
      required this.clothesType,
      required this.clothesSize,
      required this.id,
      required this.clothesName,
      this.clothesDesc,
      this.clothesImage});

  @override
  Widget build(BuildContext context) {
    Widget headerCategoryBox(String title, value) {
      return Container(
        margin: const EdgeInsets.only(right: spaceSM),
        padding: const EdgeInsets.only(right: spaceXMD, left: spaceMini),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: darkColor,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AtomsText(
              type: "content-title",
              text: title,
              color: blackColor,
              marginBottom: spaceMini,
            ),
            AtomsText(
              type: "content-sub-title",
              text: getCleanTitleFromCtx(value),
            ),
          ],
        ),
      );
    }

    return Column(children: [
      Container(
        margin: const EdgeInsets.only(right: spaceMD),
        decoration: BoxDecoration(
            color: greyColor, borderRadius: BorderRadius.circular(roundedLG)),
        width: Get.width * 0.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(roundedJumbo + roundedJumbo),
          child: Image.asset('assets/images/footwear.png', width: Get.width),
        ),
      ),
      const SizedBox(height: spaceLG),
      Row(
        children: [
          headerCategoryBox("Category", clothesCategory),
          headerCategoryBox("Type", clothesType),
          headerCategoryBox("Size", clothesSize)
        ],
      ),
      const SizedBox(height: spaceLG),
      Container(
        width: Get.width,
        padding: const EdgeInsets.all(spaceLG),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [infoBG, primaryLightBG],
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AtomsText(
                    type: "content-sub-title",
                    text: "Export Data",
                    color: whiteColor,
                  ),
                  AtomsButton(
                    type: "btn-success",
                    text: "Download PDF",
                    icon: FaIcon(
                      FontAwesomeIcons.download,
                      color: whiteColor,
                      size: textXMD,
                    ),
                  )
                ],
              ),
            ],
          ),
          const Divider(
            color: darkColor,
            height: spaceLG,
          ),
          AtomsText(
            text: ucFirstWord(clothesName),
            type: "content-title-main",
            color: blackColor,
          ),
          clothesDesc != null
              ? AtomsText(
                  text: "$clothesDesc",
                  type: "content-body",
                  color: blackColor,
                )
              : const AtomsText(
                  text: "No Description Provided",
                  type: "no-data",
                  color: blackColor,
                )
        ]),
      )
    ]);
  }
}
