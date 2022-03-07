import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mv_vendor_app/layout/cubit/cubit.dart';

import 'drawer_menu.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Drawer(
      child: Column(children: [
        Container(
          height: 120,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              DrawerHeader(
                child: cubit.doc == null
                    ? Text('Fetching...', style: TextStyle(color: Colors.white))
                    : Row(
                        children: [
                          CachedNetworkImage(imageUrl: cubit.doc!['logo']),
                          SizedBox(
                            width: 10,
                          ),
                          Text(cubit.doc!['businessName'],
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerMenu(
              icon: Icons.home_outlined,
              menuTitle: 'Home',
              route: 'HomeScreen',
            ),
          Divider(
              color: Colors.grey),
            ExpansionTile(
              leading: Icon(Icons.weekend_outlined),
              title: Text('Products'),
              children: [
                DrawerMenu(menuTitle: 'All Products', route: 'ProductsScreen'),
                DrawerMenu(
                    menuTitle: 'Add Products', route: 'AddProductsScreen'),
              ],
            ),
          ]),
        ),
        Divider(
            color: Colors.grey),
        ListTile(
            title: Text('Signout'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, 'LoginScreen');
            }),
      ]),
    );
  }
}
