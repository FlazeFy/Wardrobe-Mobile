import 'dart:convert';

class ClothesHeaderAllModel {
  String id;
  String clothesName;
  String? clothesImage;
  String clothesSize;
  String clothesGender;
  String clothesColor;
  String clothesCategory;
  String clothesType;
  int clothesQty;
  int isFaded;
  int hasWashed;
  int hasIroned;
  int isFavorite;
  int isScheduled;

  ClothesHeaderAllModel({
    required this.id,
    required this.clothesName,
    this.clothesImage,
    required this.clothesSize,
    required this.clothesGender,
    required this.clothesColor,
    required this.clothesCategory,
    required this.clothesType,
    required this.clothesQty,
    required this.isFaded,
    required this.hasWashed,
    required this.hasIroned,
    required this.isFavorite,
    required this.isScheduled,
  });

  factory ClothesHeaderAllModel.fromJson(Map<String, dynamic> map) {
    return ClothesHeaderAllModel(
      id: map['id'],
      clothesName: map['clothes_name'],
      clothesImage: map['clothes_image'],
      clothesSize: map['clothes_size'],
      clothesGender: map['clothes_gender'],
      clothesColor: map['clothes_color'],
      clothesCategory: map['clothes_category'],
      clothesType: map['clothes_type'],
      clothesQty: map['clothes_qty'],
      isFaded: map['is_faded'],
      hasWashed: map['has_washed'],
      hasIroned: map['has_ironed'],
      isFavorite: map['is_favorite'],
      isScheduled: map['is_scheduled'],
    );
  }
}

List<ClothesHeaderAllModel> clothesAllHeaderModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ClothesHeaderAllModel>.from(
      data['data']['data'].map((item) => ClothesHeaderAllModel.fromJson(item)));
}

class LastOutfitClothesModel {
  String clothesName;
  String clothesType;
  String? clothesImage;

  LastOutfitClothesModel({
    required this.clothesName,
    required this.clothesType,
    this.clothesImage,
  });

  factory LastOutfitClothesModel.fromJson(Map<String, dynamic> json) {
    return LastOutfitClothesModel(
      clothesName: json['clothes_name'],
      clothesType: json['clothes_type'],
      clothesImage: json['clothes_image'],
    );
  }
}

class LastOutfitModel {
  String id;
  String outfitName;
  int isFavorite;
  int totalUsed;
  String lastUsed;
  List<LastOutfitClothesModel> clothes;

  LastOutfitModel(
      {required this.id,
      required this.outfitName,
      required this.isFavorite,
      required this.totalUsed,
      required this.lastUsed,
      required this.clothes});

  factory LastOutfitModel.fromJson(Map<String, dynamic> map) {
    return LastOutfitModel(
        id: map['id'],
        outfitName: map['outfit_name'],
        isFavorite: map['is_favorite'],
        totalUsed: map['total_used'],
        lastUsed: map['last_used'],
        clothes: (map['clothes'] as List)
            .map((item) => LastOutfitClothesModel.fromJson(item))
            .toList());
  }
}

LastOutfitModel queriesLastOutfitModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return LastOutfitModel.fromJson(data['data']);
}
