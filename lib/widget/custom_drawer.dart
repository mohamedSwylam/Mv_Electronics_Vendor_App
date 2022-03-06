import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          child: Text('Drawer Header'),
        ),
        ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('Home'),
            ),
          ],
        ),
      ]),
    );
  }
}
