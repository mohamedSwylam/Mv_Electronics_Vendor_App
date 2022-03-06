import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/layout/cubit/cubit.dart';
import 'package:mv_vendor_app/layout/cubit/states.dart';

import '../../widget/custom_drawer.dart';
class AddProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Add new products'),
            ),
            drawer: CustomDrawer(),
          body: Center(
            child: Text(
              'AddProductsScreen',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
