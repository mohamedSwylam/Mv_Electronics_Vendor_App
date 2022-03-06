import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  String? menuTitle;
  IconData? icon;
  String? route;

  DrawerMenu({this.menuTitle, this.icon, this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon),
        title: Text(menuTitle!),
        onTap: () {
          Navigator.pushReplacementNamed(context, '$route');
        });
  }
}