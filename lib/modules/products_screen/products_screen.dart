import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/layout/cubit/cubit.dart';
import 'package:mv_vendor_app/layout/cubit/states.dart';

import '../../widget/custom_drawer.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if (cubit.doc == null) {
          cubit.getVendorData();
        }
        return DefaultTabController(
          length: 2,
          initialIndex: 0,

          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Product List'),
            ),
            drawer: CustomDrawer(),
            body: Center(
              child: Text(
                'Product List',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
