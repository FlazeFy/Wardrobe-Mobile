import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';

class HomeSectionTotalClothesByType extends StatefulWidget {
  const HomeSectionTotalClothesByType({super.key});

  @override
  State<HomeSectionTotalClothesByType> createState() =>
      _HomeSectionTotalClothesByTypeState();
}

class _HomeSectionTotalClothesByTypeState
    extends State<HomeSectionTotalClothesByType> {
  StatsQueriesService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = StatsQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getTotalClothesByType(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesPieChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesPieChartModel> contents = snapshot.data ?? [];

            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<QueriesPieChartModel> data) {
    return Container(
      width: Get.width * 0.425,
      padding: const EdgeInsets.all(spaceLG),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [infoBG, primaryLightBG],
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        const AtomsText(type: "content-title-main", text: "All Types"),
        Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: data
                .map((dt) => AtomsText(
                    text: "${dt.total} ${dt.ctx}",
                    type: "content-title",
                    color: blackColor))
                .toList())
      ]),
    );
  }
}
