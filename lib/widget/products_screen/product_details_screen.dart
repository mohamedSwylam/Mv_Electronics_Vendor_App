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

class ProductDetailsScreen extends StatefulWidget {
  final String? productId;
  final Product? product;

  const ProductDetailsScreen({this.product, this.productId, Key? key})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var productName = TextEditingController();
  var brand = TextEditingController();
  var salesPrice = TextEditingController();
  var regularPrice = TextEditingController();

  @override
  void initState() {
    productName.text = widget.product!.productName!;
    brand.text = widget.product!.brand!;
    salesPrice.text = widget.product!.salesPrice!.toString();
    regularPrice.text = widget.product!.regularPrice!.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    FirebaseService service = FirebaseService();
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              title: Text(widget.product!.productName!),
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: widget.product!.imageUrls!.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CachedNetworkImage(imageUrl: e),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Text(
                      'Brand : ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: brand,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: productName,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    if (widget.product!.salesPrice != null)
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Sales price : ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: salesPrice,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Regular price : ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: regularPrice,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        });
  }
}
