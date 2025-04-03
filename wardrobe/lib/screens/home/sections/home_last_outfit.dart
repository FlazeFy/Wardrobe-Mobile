import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class HomeSectionLastOutfit extends StatefulWidget {
  const HomeSectionLastOutfit({super.key});

  @override
  State<HomeSectionLastOutfit> createState() => _HomeSectionLastOutfitState();
}

class _HomeSectionLastOutfitState extends State<HomeSectionLastOutfit> {
  ClothesQueriesService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = ClothesQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getLastOutfit(),
        builder:
            (BuildContext context, AsyncSnapshot<LastOutfitModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            LastOutfitModel? content = snapshot.data;

            return _buildListView(content);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(LastOutfitModel? data) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(spaceLG),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data != null ? data.clothes.length : 0,
            itemBuilder: (context, index) {
              final item = data?.clothes[index];
              return Container(
                margin: const EdgeInsets.only(right: spaceSM),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: item != null
                          ? item.clothesImage != null
                              ? Image.network(
                                  item.clothesImage!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/default_clothes.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                          : Image.asset(
                              'assets/images/default_clothes.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 4),
                    AtomsText(
                        type: "content-body",
                        text: item != null ? item.clothesName : "-",
                        color: blackColor)
                  ],
                ),
              );
            },
          ),
        ),
        AtomsText(
            type: "content-sub-title",
            text:
                "Set at ${data != null ? convertDatetimeBasedLocal(data.lastUsed) : "-"}",
            color: darkColor),
        const Row(
          children: [
            AtomsText(
                type: "content-title-main",
                text: "Last",
                color: blackColor,
                marginBottom: 0),
            SizedBox(width: spaceMini),
            AtomsText(
                type: "content-title-main",
                text: "Outfit",
                color: infoBG,
                marginBottom: 0),
          ],
        ),
        const Divider(
          color: blackColor,
          height: spaceMD,
        ),
        const Row(
          children: [
            AtomsText(
                type: "content-sub-title", text: "See more outfit history?"),
            Spacer(),
            AtomsButton(
                type: "btn-primary",
                text: "History",
                icon: FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: textMD,
                  color: whiteColor,
                ))
          ],
        )
      ]),
    );
  }
}
