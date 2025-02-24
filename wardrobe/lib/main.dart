import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/organisms/o_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: whiteColor),
      home: const BottomBar(),
    );
  }
}
