import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_vendor_app/modules/register/register_screen.dart';
import 'package:mv_vendor_app/widget/landing_screen.dart';
import '../../layout/app_layout.dart';
import '../../shared/styles/color.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:sizer/sizer.dart';



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
                  subtitleBuilder: (context, action) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        action == AuthAction.signIn
                            ? 'Welcome to electronic app-vendor! Please sign in to continue.'
                            : 'Welcome to electronic app-vendor! Please create an account to continue',
                      ),
                    );
                  },
                  footerBuilder: (context, _) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'By signing in, you agree to our terms and conditions.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                  headerBuilder: (context, constraints, _) {
                    return AspectRatio(
                      aspectRatio:1,
                      child: Lottie.asset('assets/images/mob.json',width:80.w,height: 40.h,repeat: false),
                    );
                  },
                  providerConfigs: [
                    EmailProviderConfiguration(),
                    GoogleProviderConfiguration(
                        clientId: '1:843555294764:android:0d74d4d005871108ea4b89'),
                    PhoneProviderConfiguration(),
                  ],
                );
              }

              // Render your application if authenticated
              return  AppLayout();
            },
          );
        }
    );
  }
}
