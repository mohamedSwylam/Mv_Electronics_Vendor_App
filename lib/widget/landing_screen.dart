import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'your application sent to Shop App Admin \ Admin will contact you Soon',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
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
                  FirebaseAuth.instance.signOut();
                })
          ],
        ),
      )),
    );
  }
}
