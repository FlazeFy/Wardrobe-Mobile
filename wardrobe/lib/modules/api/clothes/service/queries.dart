import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/global.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/helpers/generator.dart';

class ClothesQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  DateTime now = DateTime.now();
  Client client = Client();

  Future<List<ClothesHeaderAllModel>> getAllClothesHeader(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "clothes_header-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('auth_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > clothesHeaderFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return clothesAllHeaderModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse("$emuUrl/api/v1/clothes/header/all/desc?page=$page"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return clothesAllHeaderModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return clothesAllHeaderModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return clothesAllHeaderModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<LastOutfitModel?> getLastOutfit() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "last-outfit-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('auth_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return queriesLastOutfitModelFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        final response = await client.get(
            Uri.parse("$emuUrl/api/v1/clothes/outfit/last"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return queriesLastOutfitModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return null;
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesLastOutfitModelFromJson(response.body);
            } else {
              return null;
            }
          } else {
            return null;
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return queriesLastOutfitModelFromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<List<ClothesDeletedModel>> getAllDeletedClothes(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "clothes_deleted-sess";
    final token = prefs.getString('auth_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (connectivityResult == ConnectivityResult.none) {
      if (prefs.containsKey(backupKey)) {
        final data = prefs.getString(backupKey);
        if (data != null) {
          if (!isOffline) {
            Get.snackbar("Warning", "Lost connection, all data shown are local",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = true;
          }
          return clothesDeletedModelFromJson(data);
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      final response = await client
          .get(Uri.parse("$emuUrl/api/v1/clothes/trash"), headers: header);
      if (response.statusCode == 200) {
        if (isOffline) {
          Get.snackbar("Information", "Welcome back, all data are now realtime",
              colorText: whiteColor,
              backgroundColor: darkColor,
              borderColor: primaryColor,
              borderWidth: spaceMini / 2.5);
          isOffline = false;
        }
        prefs.setString("last-hit-$backupKey", generateTempDataKey());
        prefs.setString(backupKey, response.body);
        return clothesDeletedModelFromJson(response.body);
      } else if (response.statusCode == 401) {
        return [];
      } else {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            return clothesDeletedModelFromJson(response.body);
          } else {
            return [];
          }
        } else {
          return [];
        }
      }
    }
  }

  Future<List<WashHistoryModel>> getAllWashHistory(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "wash-history-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('auth_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > clothesHeaderFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return washHistoryModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$emuUrl/api/v1/clothes/wash_history?page=$page&is_detailed=true"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return washHistoryModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return washHistoryModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return washHistoryModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<UsedHistoryModel>> getAllUsedHistory(
      int page, String order) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "used-history-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('auth_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > clothesHeaderFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return usedHistoryModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse("$emuUrl/api/v1/clothes/history/all/$order"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return usedHistoryModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return usedHistoryModelFromJson(response.body);
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return usedHistoryModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<ClothesDetailModel?> getClothesDetail(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    final token = prefs.getString('auth_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (connectivityResult == ConnectivityResult.none) {
      if (!isOffline) {
        Get.snackbar("Warning", "Lost connection, all data shown are local",
            colorText: whiteColor,
            backgroundColor: darkColor,
            borderColor: primaryColor,
            borderWidth: spaceMini / 2.5);
        isOffline = true;
      }
      return null;
    } else {
      final response = await client
          .get(Uri.parse("$emuUrl/api/v1/clothes/detail/$id"), headers: header);
      if (response.statusCode == 200) {
        if (isOffline) {
          Get.snackbar("Information", "Welcome back, all data are now realtime",
              colorText: whiteColor,
              backgroundColor: darkColor,
              borderColor: primaryColor,
              borderWidth: spaceMini / 2.5);
          isOffline = false;
        }
        return clothesDetailModelFromJson(response.body);
      } else if (response.statusCode == 401) {
        return null;
      } else {
        return null;
      }
    }
  }
}
