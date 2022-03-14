import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';
import 'package:mv_vendor_app/widget/add_product/attributes/attribute_tab.dart';
import 'package:mv_vendor_app/widget/add_product/image_tab/image_tab.dart';
import '../../widget/add_product/general_tab/general_tab.dart';
import '../../widget/add_product/inventory_tab/inventory_tab.dart';
import '../../widget/add_product/shipping_tab/shipping_tab.dart';
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
        FirebaseService service=FirebaseService();
        return Form(
          key: cubit.formKey,
          child: DefaultTabController(
            length: 6,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text('Add new products'),
                bottom: TabBar(
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 4, color: Colors.deepOrange),
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
                        child: Text('Attributes'),
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
                  InventoryTab(),
                  ShippingTab(),
                  AttributesTab(),
                  Center(child: Text('Link Pro Tab')),
                  ImageTab(),
                ],
              ),
              persistentFooterButtons: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text('Save Product'),
                    onPressed: () {
                      if (cubit.imageFiles!.isEmpty) {
                        cubit.scaffold('Image not selected',context);
                        return;
                      }
                      if (cubit.formKey.currentState!.validate()) {
                        service.uploadFiles(images: cubit.imageFiles, ref: 'products/',context: context)
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
