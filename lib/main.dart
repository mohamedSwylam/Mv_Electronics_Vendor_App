import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mv_vendor_app/modules/Login/login_screen.dart';
import 'package:mv_vendor_app/modules/register/register_screen.dart';
import 'package:mv_vendor_app/shared/bloc_observer.dart';
import 'package:mv_vendor_app/shared/network/local/cache_helper.dart';
import 'package:mv_vendor_app/widget/landing_screen.dart';
import 'layout/app_layout.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'package:sizer/sizer.dart';

import 'modules/Login/cubit/cubit.dart';
import 'modules/register/cubit/cubit.dart';
import 'modules/splash_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              title: 'Vendor App',
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              theme: ThemeData(
                fontFamily: 'Lato',
              ),
              routes: {
                'SplashScreen': (context) => SplashScreen(),
                'AppLayout': (context) => AppLayout(),
                'LoginScreen': (context) => LoginScreen(),
                'RegisterScreenn': (context) => RegisterScreenn(),
                'LandingScreen': (context) => LandingScreen(),
              },
              initialRoute: 'SplashScreen',
            );
          });
        },
      ),
    );
  }
}
