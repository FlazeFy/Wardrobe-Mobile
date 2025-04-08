import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';
import 'package:wardrobe/molecules/m_chart_single_line.dart';

class UsedSectionMonthlyClothesUsed extends StatefulWidget {
  const UsedSectionMonthlyClothesUsed({super.key});

  @override
  State<UsedSectionMonthlyClothesUsed> createState() =>
      _UsedSectionMonthlyClothesUsedState();
}

class _UsedSectionMonthlyClothesUsedState
    extends State<UsedSectionMonthlyClothesUsed> {
  List<SingleLineData> chartData = [];
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
        future: apiService?.getStatsClothesMonthlyUsed('2025'),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesPieChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesPieChartModel> contents = snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              int total = content.total;
              SingleLineData lineData = SingleLineData(label, total);
              chartData.add(lineData);
            }

            return _buildListView(chartData);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<SingleLineData> contents) {
    return Container(
        margin: const EdgeInsets.only(bottom: spaceLG),
        child: moleculesChartSingleLine(
            chartData, 'Total Used Clothes per Month', null, 'Total'));
  }
}
