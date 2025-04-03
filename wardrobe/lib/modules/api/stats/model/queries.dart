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

class ClothesSummaryModel {
  int totalClothes;
  int maxPrice;
  int avgPrice;
  int sumClothesQty;

  ClothesSummaryModel(
      {required this.totalClothes,
      required this.maxPrice,
      required this.avgPrice,
      required this.sumClothesQty});

  factory ClothesSummaryModel.fromJson(Map<String, dynamic> map) {
    return ClothesSummaryModel(
      totalClothes: map["total_clothes"],
      maxPrice: map["max_price"],
      avgPrice: map["avg_price"],
      sumClothesQty: map["sum_clothes_qty"],
    );
  }
}

ClothesSummaryModel queriesClothesSummaryModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return ClothesSummaryModel.fromJson(data['data']);
}

class CalendarClothesModel {
  String id;
  String clothesName;
  String clothesCategory;
  String clothesType;
  String? clothesImage;
  String day;
  final String? typeSchedule; // when combine in calendar screen

  CalendarClothesModel(
      {required this.id,
      required this.clothesName,
      required this.clothesCategory,
      required this.clothesType,
      this.clothesImage,
      required this.day,
      this.typeSchedule});

  factory CalendarClothesModel.fromJson(Map<String, dynamic> map) {
    return CalendarClothesModel(
        id: map['id'],
        clothesName: map['clothes_name'],
        clothesCategory: map['clothes_category'],
        clothesType: map['clothes_type'],
        clothesImage: map['clothes_image'],
        day: map['day'] ?? '',
        typeSchedule: null);
  }
  CalendarClothesModel copyWith({String? typeSchedule}) {
    return CalendarClothesModel(
      id: id,
      clothesName: clothesName,
      clothesCategory: clothesCategory,
      clothesType: clothesType,
      clothesImage: clothesImage,
      day: day,
      typeSchedule: typeSchedule ?? this.typeSchedule,
    );
  }
}

class CalendarModel {
  String date;
  List<CalendarClothesModel>? usedHistory;
  List<CalendarClothesModel>? weeklySchedule;
  List<CalendarClothesModel>? washSchedule;
  List<CalendarClothesModel>? buyedHistory;
  List<CalendarClothesModel>? addWardrobe;

  CalendarModel(
      {required this.date,
      this.usedHistory,
      this.weeklySchedule,
      this.washSchedule,
      this.buyedHistory,
      this.addWardrobe});

  factory CalendarModel.fromJson(Map<String, dynamic> map) {
    return CalendarModel(
        date: map['date'],
        usedHistory: map['used_history'] != null
            ? (map['used_history'] as List)
                .map((item) => CalendarClothesModel.fromJson(item))
                .toList()
            : null,
        weeklySchedule: map['weekly_schedule'] != null
            ? (map['weekly_schedule'] as List)
                .map((item) => CalendarClothesModel.fromJson(item))
                .toList()
            : null,
        washSchedule: map['wash_schedule'] != null
            ? (map['wash_schedule'] as List)
                .map((item) => CalendarClothesModel.fromJson(item))
                .toList()
            : null,
        buyedHistory: map['buyed_history'] != null
            ? (map['buyed_history'] as List)
                .map((item) => CalendarClothesModel.fromJson(item))
                .toList()
            : null,
        addWardrobe: map['add_wardrobe'] != null
            ? (map['add_wardrobe'] as List)
                .map((item) => CalendarClothesModel.fromJson(item))
                .toList()
            : null);
  }
}

List<CalendarModel> queriesCalendarModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<CalendarModel>.from(
      data['data'].map((item) => CalendarModel.fromJson(item)));
}

class WelcomeStatsModel {
  int totalClothes;
  int totalUser;
  int totalSchedule;
  int totalOutfitDecision;

  WelcomeStatsModel(
      {required this.totalClothes,
      required this.totalUser,
      required this.totalSchedule,
      required this.totalOutfitDecision});

  factory WelcomeStatsModel.fromJson(Map<String, dynamic> map) {
    return WelcomeStatsModel(
      totalClothes: map["total_clothes"],
      totalUser: map["total_user"],
      totalSchedule: map["total_schedule"],
      totalOutfitDecision: map["total_outfit_decision"],
    );
  }
}

WelcomeStatsModel welcomeStatsModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return WelcomeStatsModel.fromJson(data['data']);
}
