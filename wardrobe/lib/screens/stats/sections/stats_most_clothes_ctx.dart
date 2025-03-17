import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';
import 'package:wardrobe/molecules/m_chart_pie.dart';

class StatsSectionMostClothesCtx extends StatefulWidget {
  const StatsSectionMostClothesCtx({super.key});

  @override
  State<StatsSectionMostClothesCtx> createState() =>
      _StatsSectionMostClothesCtxState();
}

class _StatsSectionMostClothesCtxState
    extends State<StatsSectionMostClothesCtx> {
  QueriesStatsService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesStatsService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder<QueriesMostClothesCtxModel?>(
        future: apiService?.getMostClothesContext(),
        builder: (BuildContext context,
            AsyncSnapshot<QueriesMostClothesCtxModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return Center(child: Text("No data available"));
            }
            QueriesMostClothesCtxModel contents = snapshot.data!;
            List<Widget> pieCharts = [];

            pieCharts.add(_buildPieChart(contents.clothesType, "By Its Type"));
            pieCharts.add(_buildPieChart(contents.clothesMerk, "By Its Merk"));
            pieCharts.add(_buildPieChart(contents.clothesSize, "By Its Size"));
            pieCharts.add(
                _buildPieChart(contents.clothesMadeFrom, "By Its Made From"));
            pieCharts.add(
                _buildPieChart(contents.clothesCategory, "By Its Category"));

            return SingleChildScrollView(
              child: Column(
                children: pieCharts,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPieChart(List<ClothesContext> data, String title) {
    List<PieData> chartData = data.map((item) {
      return PieData(item.context, item.total);
    }).toList();

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: moleculesChartPie(chartData, title),
    );
  }
}
