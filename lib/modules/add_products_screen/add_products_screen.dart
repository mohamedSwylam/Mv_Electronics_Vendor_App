import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widget/add_product/general_tab.dart';
import '../../widget/custom_drawer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AddProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AddProductCubit.get(context);
        return DefaultTabController(
          length: 5,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Add new products'),
              bottom: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4, color: Colors.deepOrange),
                  ),
                  tabs: [
                    Tab(
                      child: Text('General'),
                    ),
                    Tab(
                      child: Text('Inventory'),
                    ),
                    Tab(
                      child: Text('Shipping'),
                    ),
                    Tab(
                      child: Text('Linked Products'),
                    ),
                    Tab(
                      child: Text('Images'),
                    ),
                  ]),
            ),
            drawer: CustomDrawer(),
            body: TabBarView(
              children: [
                GeneralTab(),
                Center(child: Text('Inventory Tab')),
                Center(child: Text('Shipping Tab')),
                Center(child: Text('Link Pro Tab')),
                Center(child: Text('Taages Tab')),
              ],
            ),
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Save Product'),
                  onPressed: () {
                    print(cubit.categories);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
