import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/home/sections/home_total_clothes_by_type.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  StateHomePageState createState() => StateHomePageState();
}

class StateHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: const [
        Row(
          children: [HomeSectionTotalClothesByType()],
        )
      ],
    ));
  }
}
