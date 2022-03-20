import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:mv_vendor_app/widget/products_screen/product_details_screen.dart';

import '../../models/product_model.dart';
import '../../modules/products_screen/cubit/cubit.dart';
import '../../services/firebase_service.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.cubit,
    required this.service,
    required this.snapshot,
  }) : super(key: key);

  final ProductCubit cubit;
  final FirebaseService service;
  final FirestoreQueryBuilderSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            Product product = snapshot.docs[index].data();
            var discount = (product.regularPrice! - product.salesPrice!) -
                product.regularPrice! * 100;
            String id = snapshot.docs[index].id;
            return Slidable(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductDetailsScreen(
                              product: product,
                              productId: id,
                            ),
                      ));
                },
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
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${discount.toInt()}%',
                                style: TextStyle(color: Colors.red),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    flex: 1,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      service.products.doc(id).update({
                        'approved': product.approved == false ? true : false
                      });
                    },
                    flex: 1,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.approval,
                    label: product.approved == false ? 'Approve' : 'Inactive',
                  ),
                ],
              ),
            );
          }),
    );
  }
}
