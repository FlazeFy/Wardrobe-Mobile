import 'dart:convert';

class PieData {
  PieData(this.xData, this.yData, [this.text = ""]);
  final String xData;
  final num yData;
  final String text;
}

class TwoLineData {
  TwoLineData(this.xData, this.yData, this.zData, [this.text = ""]);
  final String xData;
  final num yData;
  final num zData;
  final String text;
}

class QueriesPieChartModel {
  String ctx;
  int total;

  QueriesPieChartModel({required this.ctx, required this.total});

  factory QueriesPieChartModel.fromJson(Map<String, dynamic> map) {
    return QueriesPieChartModel(
      ctx: map["context"],
      total: map["total"],
    );
  }
}

List<QueriesPieChartModel> queriesPieChartModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesPieChartModel>.from(
      data['data'].map((item) => QueriesPieChartModel.fromJson(item)));
}

class QueriesMostClothesCtxModel {
  List<ClothesContext> clothesType;
  List<ClothesContext> clothesMerk;
  List<ClothesContext> clothesSize;
  List<ClothesContext> clothesMadeFrom;
  List<ClothesContext> clothesCategory;

  QueriesMostClothesCtxModel({
    required this.clothesType,
    required this.clothesMerk,
    required this.clothesSize,
    required this.clothesMadeFrom,
    required this.clothesCategory,
  });

  factory QueriesMostClothesCtxModel.fromJson(Map<String, dynamic> map) {
    final data = map["data"] ?? {};

    return QueriesMostClothesCtxModel(
      clothesType: _parseClothesContext(data["clothes_type"]),
      clothesMerk: _parseClothesContext(data["clothes_merk"]),
      clothesSize: _parseClothesContext(data["clothes_size"]),
      clothesMadeFrom: _parseClothesContext(data["clothes_made_from"]),
      clothesCategory: _parseClothesContext(data["clothes_category"]),
    );
  }

  static List<ClothesContext> _parseClothesContext(dynamic jsonList) {
    if (jsonList is List) {
      return jsonList.map((item) => ClothesContext.fromJson(item)).toList();
    }
    return [];
  }
}

class ClothesContext {
  String context;
  int total;

  ClothesContext({required this.context, required this.total});

  factory ClothesContext.fromJson(Map<String, dynamic> map) {
    return ClothesContext(
      context: map["context"] ?? "",
      total: map["total"] ?? 0,
    );
  }
}

QueriesMostClothesCtxModel queriesMostClothesCtxModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return QueriesMostClothesCtxModel.fromJson(data);
}

class StatsMonthlyClothesModel {
  String ctx;
  int totalCreated;
  int totalBuyed;

  StatsMonthlyClothesModel({
    required this.ctx,
    required this.totalCreated,
    required this.totalBuyed,
  });

  factory StatsMonthlyClothesModel.fromJson(Map<dynamic, dynamic> map) {
    return StatsMonthlyClothesModel(
      ctx: map["context"],
      totalCreated: map["total_created"],
      totalBuyed: map["total_buyed"],
    );
  }
}

List<StatsMonthlyClothesModel> statsMonthlyClothesModelFromJson(
    String jsonData) {
  final data = json.decode(jsonData);
  return List<StatsMonthlyClothesModel>.from(
      data['data'].map((item) => StatsMonthlyClothesModel.fromJson(item)));
}

class ClothesSummary {
  int totalClothes;
  int maxPrice;
  int avgPrice;
  int sumClothesQty;

  ClothesSummary(
      {required this.totalClothes,
      required this.maxPrice,
      required this.avgPrice,
      required this.sumClothesQty});

  factory ClothesSummary.fromJson(Map<String, dynamic> map) {
    return ClothesSummary(
      totalClothes: map["total_clothes"],
      maxPrice: map["max_price"],
      avgPrice: map["avg_price"],
      sumClothesQty: map["sum_clothes_qty"],
    );
  }
}

ClothesSummary queriesClothesSummaryModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return ClothesSummary.fromJson(data['data']);
}
