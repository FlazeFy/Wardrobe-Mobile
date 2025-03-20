import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/design_tokens/global.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/calendar/index.dart';
import 'package:wardrobe/screens/clothes/index.dart';
import 'package:wardrobe/screens/home/index.dart';
import 'package:wardrobe/screens/profile/index.dart';
import 'package:wardrobe/screens/stats/index.dart';

class OrganismsBottomBar extends StatefulWidget {
  const OrganismsBottomBar({key}) : super(key: key);

  @override
  OrganismsBottomBarState createState() => OrganismsBottomBarState();
}

class OrganismsBottomBarState extends State<OrganismsBottomBar> {
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ClothesPage(),
    const CalendarPage(),
    const StatsPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(
            color: greyColor,
            border: Border(
              top: BorderSide(color: blackColor, width: spaceMini / 2),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: greyColor),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.house),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.shirt),
                  label: 'Clothes',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.calendar),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.chartSimple),
                  label: 'Stats',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.user),
                  label: 'Profile',
                )
              ],
              backgroundColor: darkColor,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedItemColor: shadowColor,
              selectedItemColor: infoBG,
              selectedIconTheme: const IconThemeData(
                  color: infoBG, size: textJumbo - textMini / 2),
              unselectedIconTheme: const IconThemeData(
                  color: shadowColor, size: textXLG + textMini / 2.5),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
