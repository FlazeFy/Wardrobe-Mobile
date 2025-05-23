import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/global.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/helpers/generator.dart';

class StatsQueriesService {
  final String baseUrl = "http://10.0.2.2:8000";
  DateTime now = DateTime.now();
  Client client = Client();

  Future<QueriesMostClothesCtxModel?> getMostClothesContext() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "most-clothes-context-sess";
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
            return queriesMostClothesCtxModelFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        final response = await client.post(
            Uri.parse(
                "$baseUrl/api/v1/stats/clothes/by/clothes_type,clothes_merk,clothes_size,clothes_made_from,clothes_category"),
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
          return queriesMostClothesCtxModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return null;
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesMostClothesCtxModelFromJson(response.body);
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
        return queriesMostClothesCtxModelFromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<List<StatsMonthlyClothesModel>> getMonthlyClothesPerMonth(
      String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "monthly-clothes-$year-sess";
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
            return statsMonthlyClothesModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/clothes/monthly/created_buyed/$year"),
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
          return statsMonthlyClothesModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return statsMonthlyClothesModelFromJson(response.body);
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
        return statsMonthlyClothesModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<QueriesPieChartModel>> getTotalClothesByType() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "total-clothes-by-type-sess";
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
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.post(
            Uri.parse("$baseUrl/api/v1/stats/clothes/by/clothes_type"),
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
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
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
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<ClothesSummaryModel?> getClothesSummary() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "clothes-summary-sess";
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
            return queriesClothesSummaryModelFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        final response = await client.get(
            Uri.parse("$baseUrl/api/v1/stats/clothes/summary"),
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
          return queriesClothesSummaryModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return null;
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesClothesSummaryModelFromJson(response.body);
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
        return queriesClothesSummaryModelFromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<List<CalendarModel>> getCalendar(int month, year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "calendar-sess";
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
          return queriesCalendarModelFromJson(data);
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      final response = await client.get(
          Uri.parse("$baseUrl/api/v1/stats/calendar/$month/$year"),
          headers: header);
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
        return queriesCalendarModelFromJson(response.body);
      } else if (response.statusCode == 401) {
        return [];
      } else {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            return queriesCalendarModelFromJson(response.body);
          } else {
            return [];
          }
        } else {
          return [];
        }
      }
    }
  }

  Future<WelcomeStatsModel?> getWelcomingStats() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "welcoming-stats-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final header = {
      'Accept': 'application/json',
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
            return welcomeStatsModelFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        final response = await client
            .get(Uri.parse("$baseUrl/api/v1/stats/all"), headers: header);
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
          return welcomeStatsModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return null;
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return welcomeStatsModelFromJson(response.body);
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
        return welcomeStatsModelFromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<WashSummaryModel?> getWashSummary() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "wash-summary-sess";
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
            return washSummaryModelFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        final response = await client.get(
            Uri.parse("$baseUrl/api/v1/stats/wash/summary"),
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
          return washSummaryModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return null;
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return washSummaryModelFromJson(response.body);
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
        return washSummaryModelFromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<List<QueriesPieChartModel>> getOutfitMonthlyTotalUsed(
      String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "monthly-outfit-total-used-$year-sess";
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
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse(
                "$baseUrl/api/v1/stats/outfit/monthly/by_outfit/$year/all"),
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
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
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
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<QueriesPieChartModel>> getOutfitMostUsed(String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "most-used-outfit-$year-sess";
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
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse("$baseUrl/api/v1/stats/outfit/most/used/$year"),
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
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
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
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }

  Future<List<QueriesPieChartModel>> getStatsClothesMonthlyUsed(
      String year) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "clothes-monthly-used-$year-sess";
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
            return queriesPieChartModelFromJson(data);
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        final response = await client.get(
            Uri.parse("$baseUrl/api/v1/stats/clothes/monthly/used/$year"),
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
          return queriesPieChartModelFromJson(response.body);
        } else if (response.statusCode == 401) {
          return [];
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesPieChartModelFromJson(response.body);
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
        return queriesPieChartModelFromJson(data);
      } else {
        return [];
      }
    }
  }
}
