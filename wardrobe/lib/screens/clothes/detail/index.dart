import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';
import 'package:wardrobe/molecules/m_menu_button.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/detail/sections/detail_clothes_header.dart';
import 'package:wardrobe/screens/clothes/detail/sections/detail_schedule.dart';
import 'package:wardrobe/screens/clothes/detail/used/index.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  StateDetailPageState createState() => StateDetailPageState();
}

class StateDetailPageState extends State<DetailPage> {
  ClothesQueriesService? apiQuery;
  @override
  void initState() {
    super.initState();
    apiQuery = ClothesQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiQuery?.getClothesDetail(widget.id),
        builder: (BuildContext context,
            AsyncSnapshot<ClothesDetailModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            ClothesDetailModel? content = snapshot.data;

            return _buildListView(content);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(ClothesDetailModel? data) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Used History Page")),
        body: ListView(padding: const EdgeInsets.all(spaceMD), children: [
          DetailSectionClothesHeader(
              clothesCategory: data?.detail.clothesCategory ?? "",
              clothesType: data?.detail.clothesType ?? "",
              clothesSize: data?.detail.clothesSize ?? "",
              clothesDesc: data?.detail.clothesDesc,
              clothesImage: data?.detail.clothesImage,
              id: widget.id,
              clothesName: data?.detail.clothesName ?? ""),
          const SizedBox(height: spaceMD),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MoleculesMenuButton(
                    title: "Used History",
                    desc:
                        "Start from ${convertDatetimeBasedLocal(data!.lastUsedHistory ?? "")}, this clothes has been used for ${data.totalUsedHistory} times.",
                    urlImage: "assets/images/generate_outfit.jpg",
                    action: () {
                      Get.to(DetailUsedPage(
                          items: data.usedHistory ?? [],
                          clothesName: data?.detail.clothesName ?? ""));
                    }),
                MoleculesMenuButton(
                    title: "Generated Outfit",
                    desc:
                        "This clothes has found in ${data.outfit != null ? data.outfit?.length : 0} outfit",
                    urlImage: "assets/images/generate_outfit.jpg",
                    action: () {}),
              ],
            ),
          ),
          const SizedBox(height: spaceMD),
          DetailSectionSchedule(schedule: data.schedule ?? [])
        ]));
  }
}
