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
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(roundedLG),
              topLeft: Radius.circular(roundedLG),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.house,
                      color: whiteColor,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.shirt,
                      color: whiteColor,
                    ),
                    label: 'Clothes',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.calendar,
                      color: whiteColor,
                    ),
                    label: 'Calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.chartSimple,
                      color: whiteColor,
                    ),
                    label: 'Stats',
                  ),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.user, color: whiteColor),
                      label: 'Profile')
                ],
                backgroundColor: whiteColor,
                unselectedItemColor: shadowColor,
                selectedItemColor: primaryColor,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            )));
  }
}
