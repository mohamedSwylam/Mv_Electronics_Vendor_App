import 'package:flutter/material.dart';

import 'drawer_menu.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 86,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              DrawerHeader(
                child: Text('Drawer Header',style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerMenu(icon: Icons.home_outlined,menuTitle: 'Home',route: 'HomeScreen', ),
                DrawerMenu(icon: Icons.home_outlined,menuTitle: 'Home',route: 'HomeScreen', ),
                DrawerMenu(icon: Icons.home_outlined,menuTitle: 'Home',route: 'HomeScreen', ),
                DrawerMenu(icon: Icons.home_outlined,menuTitle: 'Home',route: 'HomeScreen', ),
            ],
          ),
        ),
      ]),
    );
  }
}
