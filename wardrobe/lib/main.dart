import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/sqlite/init.dart';
import 'package:wardrobe/organisms/o_bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseHelper dbHelper = DatabaseHelper();

  await dbHelper.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: OrganismsBottomBar(),
    );
  }
}
