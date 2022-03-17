import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Center(
                  child: Text('Pulished Products'),
                ),
              ],
            ),
          );
        });
  }
}
