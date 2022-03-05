import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mv_vendor_app/layout/app_layout.dart';
import 'package:mv_vendor_app/models/vendor_model.dart';
import 'package:mv_vendor_app/modules/register/register_screen.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';

import '../modules/Login/login_screen.dart';
import '../modules/home_screen/home_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: service.vendor.doc(service.user!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.data!.exists) {
            return RegisterScreenn();
          }
          Vendor vendor =
              Vendor.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          if (vendor.approved == true) {
            return AppLayout();
          }
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: vendor.logo!,
                      placeholder: (context, url) => Container(
                          height: 100, width: 100, color: Colors.grey.shade300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  vendor.businessName!,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'your application sent to Shop App \n Admin will contact you Soon',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ), // ButtonStyle
                    child: Text('Sign Out'),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LandingScreen()),
                        );
                      });
                    })
              ],
            ),
          ));
        },
      ),
    );
  }
}
