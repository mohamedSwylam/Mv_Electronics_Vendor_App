import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: snapshot.docs.length,
                    itemBuilder: (context, index) {
                      Product product = snapshot.docs[index].data();
                      var discount =(product.regularPrice!-product.salesPrice!)-product.regularPrice!*100;
                      return Slidable(
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: product.imageUrls![0],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.productName!),
                                      Row(children: [
                                        if (product.salesPrice != null)
                                          Text(cubit.formattedNumber(product.salesPrice)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          cubit.formattedNumber(product.regularPrice),
                                          style: TextStyle(
                                            decoration: product.salesPrice != null
                                                ? TextDecoration.lineThrough
                                                : null,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text('${discount.toInt()}%', style: TextStyle(color: Colors.red),),
                                      ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        endActionPane: ActionPane(
                        motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context){},
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                            SlidableAction(
                              onPressed: (context){},
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.share,
                              label: 'Share',
                            ),
                          ],
                      ),
                      );
                    }),
              );
            },
          );
        });
  }
}
