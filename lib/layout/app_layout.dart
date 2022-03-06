import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:mv_vendor_app/widget/custom_drawer.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AppLayout extends StatefulWidget {
  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('DashBoard'),
            elevation: 0.0,
          ),
          drawer: CustomDrawer(),
          body: Center(child: Text('DashBoard',style: TextStyle(fontSize: 22),)),
        );
      },
    );
  }
}
