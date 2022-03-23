import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:mv_vendor_app/models/product_model.dart';
import 'package:mv_vendor_app/shared/components/custom_text_field.dart';
import 'package:mv_vendor_app/widget/products_screen/product_card.dart';
import '../../../modules/add_products_screen/cubit/cubit.dart';
import '../../../modules/add_products_screen/cubit/states.dart';
import '../../../services/firebase_service.dart';
import '../products_screen/cubit/cubit.dart';
import '../products_screen/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String? productId;
  final Product? product;

  const ProductDetailsScreen({this.product, this.productId, Key? key})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final productName = TextEditingController();
  final brand = TextEditingController();
  final salesPrice = TextEditingController();
  final regularPrice = TextEditingController();
  final description = TextEditingController();
  final soh = TextEditingController();
  final reOrderLevel = TextEditingController();
  String? taxStatus;
  String? taxAmount;

  @override
  void initState() {
    setState(() {
      productName.text = widget.product!.productName!;
      description.text = widget.product!.description!;
      brand.text = widget.product!.brand!;
      salesPrice.text = widget.product!.salesPrice!.toString();
      regularPrice.text = widget.product!.regularPrice!.toString();
      soh.text = widget.product!.soh!.toString();
      reOrderLevel.text = widget.product!.reorderLevel!.toString();
      taxStatus = widget.product!.taxStatus!;
      taxAmount = widget.product!.taxPercentage == 10 ? 'GST-10%' : 'GST-12%';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    return BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProductDetailsCubit.get(context);
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
                      child: CustomTextFormField(
                        controller: brand,
                        inputType: TextInputType.text,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: productName,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: description,
                    inputType: TextInputType.text,
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
                            Expanded(
                              child: CustomTextFormField(
                                controller: salesPrice,
                                inputType: TextInputType.number,
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
                            child: CustomTextFormField(
                              controller: regularPrice,
                              inputType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Expanded(child: cubit.taxStatusDropDown()),
                      SizedBox(
                        width: 10,
                      ),
                      if (cubit.taxStatus == 'Taxable')
                        Expanded(child: cubit.taxAmountDropDown()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                    child: Row(children: [
                      Text(
                        'Category: ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(widget.product!.category!),
                    ]),
                  ),
                  if (widget.product!.mainCategory != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                      child: Row(
                        children: [
                          Text(
                            'Main Category: ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(widget.product!.mainCategory!),
                        ],
                      ),
                    ),
                  if (widget.product!.subCategory != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                      child: Row(children: [
                        Text(
                          'Sub Category: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.product!.subCategory!),
                      ]),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                    child: Row(children: [
                      Text(
                        'SKU: ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(widget.product!.sku!),
                    ]),
                  ),
                  if (widget.product!.manageInventory == true)
                   Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 10, bottom: 10),
                         child: Row(children: [
                           Text(
                             'SOH : ',
                             style: TextStyle(color: Colors.grey),
                           ),
                           Expanded(
                             child: CustomTextFormField(
                               controller: soh,
                               inputType: TextInputType.number,
                             ),
                           ),
                         ]),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 10, bottom: 10),
                         child: Row(children: [
                           Text(
                             'Re-Order Level : ',
                             style: TextStyle(color: Colors.grey),
                           ),
                           Expanded(
                             child: CustomTextFormField(
                               controller: reOrderLevel,
                               inputType: TextInputType.number,
                             ),
                           ),
                         ]),
                       ),
                     ],
                   ),
                ],
              ),
            ),
          );
        });
  }
}
