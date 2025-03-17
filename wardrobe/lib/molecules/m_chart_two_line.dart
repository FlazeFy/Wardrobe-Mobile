import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';

Widget moleculesChartTwoLine(List<TwoLineData> chartData, String? title,
    String? extra, String lineOne, String lineTwo) {
  return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.35),
              blurRadius: spaceLG,
              spreadRadius: 0.0,
              offset: const Offset(
                spaceMini,
                spaceMini,
              ),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(roundedJumbo))),
      child: SfCartesianChart(
        title: title != null
            ? ChartTitle(
                text: title,
                textStyle: const TextStyle(
                    color: darkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: textLG),
              )
            : ChartTitle(),
        legend: Legend(
            position: LegendPosition.bottom,
            isVisible: true,
            textStyle: const TextStyle(
              color: darkColor,
            )),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(
            text: '',
          ),
          labelStyle: const TextStyle(
            color: darkColor,
          ),
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: '',
          ),
          labelStyle: const TextStyle(
            color: darkColor,
          ),
        ),
        axes: <ChartAxis>[
          NumericAxis(
            name: 'secondaryYAxis',
            opposedPosition: true,
            title: AxisTitle(
              text: '',
            ),
          ),
        ],
        series: <CartesianSeries>[
          SplineSeries<TwoLineData, String>(
            dataSource: chartData,
            xValueMapper: (TwoLineData data, _) => data.xData,
            yValueMapper: (TwoLineData data, _) => data.yData,
            name: lineOne,
            dataLabelMapper: (TwoLineData data, _) => data.yData != 0
                ? '${extra ?? ''}${double.parse(data.yData.toStringAsFixed(2))}'
                : null,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                fontSize: textSM,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
            ),
          ),
          BarSeries<TwoLineData, String>(
            dataSource: chartData,
            xValueMapper: (TwoLineData data, _) => data.xData,
            yValueMapper: (TwoLineData data, _) => data.zData,
            name: lineTwo,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(roundedSM),
              topRight: Radius.circular(roundedSM),
            ),
            dataLabelMapper: (TwoLineData data, _) => data.zData != 0
                ? '${extra ?? ''}${double.parse(data.zData.toStringAsFixed(2))}'
                : null,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                  fontSize: textSM,
                  fontWeight: FontWeight.w500,
                  color: darkColor),
            ),
          ),
        ],
      ));
}
