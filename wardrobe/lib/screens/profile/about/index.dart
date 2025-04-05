import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/profile/about/sections/about_apps.dart';
import 'package:wardrobe/screens/profile/about/sections/about_creator.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  StateAboutUsPageState createState() => StateAboutUsPageState();
}

class StateAboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "About Us")),
        body: ListView(
          padding: const EdgeInsets.all(spaceMD),
          children: const [
            AboutSectionApps(),
            SizedBox(height: spaceMD),
            AboutSectionCreator()
          ],
        ));
  }
}
