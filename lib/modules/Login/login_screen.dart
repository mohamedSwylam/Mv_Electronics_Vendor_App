import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            // If the user is already signed-in, use it as initial data
            initialData: FirebaseAuth.instance.currentUser,
            builder: (context, snapshot) {
              // User is not signed in
              if (!snapshot.hasData) {
                return SignInScreen(
                    providerConfigs: []
                );
              }
              return YourApplication();
            },
          );
        }
    );
  }
}
