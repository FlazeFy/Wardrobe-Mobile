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

  factory LastOutfitClothesModel.fromJson(Map<String, dynamic> map) {
    return LastOutfitClothesModel(
      clothesName: map['clothes_name'],
      clothesType: map['clothes_type'],
      clothesImage: map['clothes_image'],
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

class ClothesDeletedModel {
  String id;
  String clothesName;
  String? clothesDesc;
  String? clothesImage;
  String clothesSize;
  String clothesGender;
  String clothesColor;
  String clothesCategory;
  String clothesType;
  int clothesQty;
  String deletedAt;

  ClothesDeletedModel(
      {required this.id,
      required this.clothesName,
      this.clothesDesc,
      this.clothesImage,
      required this.clothesSize,
      required this.clothesGender,
      required this.clothesColor,
      required this.clothesCategory,
      required this.clothesType,
      required this.clothesQty,
      required this.deletedAt});

  factory ClothesDeletedModel.fromJson(Map<String, dynamic> map) {
    return ClothesDeletedModel(
      id: map['id'],
      clothesName: map['clothes_name'],
      clothesDesc: map['clothes_desc'],
      clothesImage: map['clothes_image'],
      clothesSize: map['clothes_size'],
      clothesGender: map['clothes_gender'],
      clothesColor: map['clothes_color'],
      clothesCategory: map['clothes_category'],
      clothesType: map['clothes_type'],
      clothesQty: map['clothes_qty'],
      deletedAt: map['deleted_at'],
    );
  }
}

List<ClothesDeletedModel> clothesDeletedModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ClothesDeletedModel>.from(
      data['data']['data'].map((item) => ClothesDeletedModel.fromJson(item)));
}

class WashCheckpointModel {
  String id;
  String checkpointName;
  bool isFinished;

  WashCheckpointModel({
    required this.id,
    required this.checkpointName,
    required this.isFinished,
  });

  factory WashCheckpointModel.fromJson(Map<String, dynamic> map) {
    return WashCheckpointModel(
      id: map['id'],
      checkpointName: map['checkpoint_name'],
      isFinished: map['is_finished'],
    );
  }
}

class WashHistoryModel {
  String id;
  String clothesName;
  String washType;
  String? washNote;
  List<WashCheckpointModel> washCheckpoint;
  String? clothesMerk;
  String clothesMadeFrom;
  String clothesColor;
  String clothesType;
  String washAt;
  String? finishedAt;

  WashHistoryModel(
      {required this.id,
      required this.clothesName,
      required this.washType,
      this.washNote,
      required this.washCheckpoint,
      this.clothesMerk,
      required this.clothesMadeFrom,
      required this.clothesColor,
      required this.clothesType,
      required this.washAt,
      this.finishedAt});

  factory WashHistoryModel.fromJson(Map<String, dynamic> map) {
    return WashHistoryModel(
      id: map['id'],
      clothesName: map['clothes_name'],
      washType: map['wash_type'],
      washNote: map['wash_note'],
      washCheckpoint: (map['wash_checkpoint'] as List)
          .map((item) => WashCheckpointModel.fromJson(item))
          .toList(),
      clothesMerk: map['clothes_name'],
      clothesMadeFrom: map['clothes_made_from'],
      clothesColor: map['clothes_color'],
      clothesType: map['clothes_type'],
      washAt: map['wash_at'],
      finishedAt: map['finished_at'],
    );
  }
}

List<WashHistoryModel> washHistoryModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<WashHistoryModel>.from(
      data['data']['data'].map((item) => WashHistoryModel.fromJson(item)));
}

class UsedHistoryModel {
  String id;
  String clothesName;
  String clothesType;
  String? clothesNote;
  String usedContext;
  String createdAt;

  UsedHistoryModel(
      {required this.id,
      required this.clothesName,
      required this.clothesType,
      this.clothesNote,
      required this.usedContext,
      required this.createdAt});

  factory UsedHistoryModel.fromJson(Map<String, dynamic> map) {
    return UsedHistoryModel(
      id: map['id'],
      clothesName: map['clothes_name'],
      clothesType: map['clothes_type'],
      clothesNote: map['clothes_note'],
      usedContext: map['used_context'],
      createdAt: map['created_at'],
    );
  }
}

List<UsedHistoryModel> usedHistoryModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<UsedHistoryModel>.from(
      data['data']['data'].map((item) => UsedHistoryModel.fromJson(item)));
}
