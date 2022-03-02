import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_vendor_app/layout/cubit/cubit.dart';
import 'package:mv_vendor_app/shared/network/local/cache_helper.dart';
import 'package:mv_vendor_app/shared/styles/color.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  {
  @override
  void initState() {

  Timer(Duration(seconds: 8), (){
    Navigator.pushNamedAndRemoveUntil(context,'LoginScreen', (route) => false);
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/mob.json',width:80.w,height: 30.h,repeat: false),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Electronics  App \n (Vendor)",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: defaultColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
