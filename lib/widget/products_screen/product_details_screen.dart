import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:mv_vendor_app/models/product_model.dart';
import 'package:mv_vendor_app/widget/products_screen/product_card.dart';
import '../../../modules/add_products_screen/cubit/cubit.dart';
import '../../../modules/add_products_screen/cubit/states.dart';
import '../../../services/firebase_service.dart';
import '../../modules/products_screen/cubit/cubit.dart';
import '../../modules/products_screen/cubit/states.dart';

class PublishedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    FirebaseService service = FirebaseService();
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView(
            children: [

            ],
          );
        });
  }
}
