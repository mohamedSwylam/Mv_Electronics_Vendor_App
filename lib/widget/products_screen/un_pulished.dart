import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:mv_vendor_app/models/product_model.dart';
import '../../../modules/add_products_screen/cubit/cubit.dart';
import '../../../modules/add_products_screen/cubit/states.dart';
import '../../../services/firebase_service.dart';
import '../../modules/products_screen/cubit/cubit.dart';
import '../../modules/products_screen/cubit/states.dart';


class UnPublishedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    FirebaseService service = FirebaseService();
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return FirestoreQueryBuilder<Product>(
            query: productQuery(false),
            builder: (context, snapshot, _) {
              if (snapshot.isFetching) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              }

              return ListView.builder (
                  itemCount: snapshot.docs.length,
                  itemBuilder: (context, index){
                Product product = snapshot.docs[index].data();
                return ListTile(
                    title: Text(product.productName!),
                );
              });
            },
          );
        });
  }
}
