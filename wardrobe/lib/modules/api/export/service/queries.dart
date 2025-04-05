import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/global.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/helpers/converter.dart';
import 'package:wardrobe/screens/landing/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<void> getExport(String ctx, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_key');

    final connectivityResult = await (Connectivity().checkConnectivity());
    final headers = {
      'Accept':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'Authorization': 'Bearer $token',
    };

    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Warning", "Lost connection, try again later",
          colorText: whiteColor,
          backgroundColor: darkColor,
          borderColor: primaryColor,
          borderWidth: spaceMini / 2.5);
      isOffline = true;
      return;
    }

    try {
      final response = await client.get(
        Uri.parse("$emuUrl/api/v1/export/$ctx/$type"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        if (isOffline) {
          Get.snackbar("Information", "Welcome back, all data are now realtime",
              colorText: whiteColor,
              backgroundColor: darkColor,
              borderColor: primaryColor,
              borderWidth: spaceMini / 2.5);
          isOffline = false;
        }

        String? filename = 'exported_data.xlsx';
        final contentDisp = response.headers['content-disposition'];
        if (contentDisp != null && contentDisp.contains('filename=')) {
          final regex = RegExp(r'filename="?(.+)"?');
          final match = regex.firstMatch(contentDisp);
          if (match != null) {
            filename = match.group(1)!;
          }
        }

        final status = await Permission.storage.request();
        if (!status.isGranted) {
          Get.snackbar("Permission Denied",
              "Storage access is required to download files.");
          return;
        }

        final bytes = response.bodyBytes;
        final dir = await getExternalStorageDirectory();
        final downloadPath = dir!.path;
        final file = File('$downloadPath/$filename');
        await file.writeAsBytes(bytes);

        Get.snackbar("Success!", "${getCleanTitleFromCtx(ctx)} data downloaded",
            colorText: whiteColor,
            backgroundColor: darkColor,
            borderColor: primaryColor,
            borderWidth: spaceMini / 2.5);

        await OpenFile.open(file.path);
      } else {
        if (response.statusCode == 401) {
          Get.to(() => const LoginPage());
        }

        Get.snackbar(
            "Warning", "${getCleanTitleFromCtx(ctx)} data failed to download",
            colorText: whiteColor,
            backgroundColor: darkColor,
            borderColor: primaryColor,
            borderWidth: spaceMini / 2.5);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to download file: $e",
          colorText: whiteColor,
          backgroundColor: darkColor,
          borderColor: primaryColor,
          borderWidth: spaceMini / 2.5);
    }
  }
}
