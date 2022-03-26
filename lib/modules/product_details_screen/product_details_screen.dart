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
  @override
  void initState() {
    ProductDetailsCubit.get(context).getProductData(widget.product!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    return BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProductDetailsCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                title: Text(widget.product!.productName!),
                actions: [
                  cubit.editable
                      ? IconButton(
                          icon: Icon(Icons.edit_outlined),
                          onPressed: () {
                            cubit.changeToEdit();
                          })
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                              ),
                              child: Text("Save"),
                              onPressed: () {
                                cubit.changeToSave();
                              }),
                        ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  children: [
                    AbsorbPointer(
                      absorbing: cubit.editable,
                      child: Column(
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
                                controller: cubit.brand,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            controller: cubit.productName,
                            inputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            controller: cubit.description,
                            inputType: TextInputType.text,
                          ),
                          CustomTextFormField(
                            controller: cubit.otherDetails,
                            inputType: TextInputType.text,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Text('Unit :'),
                                  Text(widget.product!.unit!),
                                ],
                              )),
                          // Row
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.grey.shade400,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(children: [
                                    if (widget.product!.salesPrice != null)
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Sales price : ',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Expanded(
                                              child: CustomTextFormField(
                                                controller: cubit.salesPrice,
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
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: CustomTextFormField(
                                              controller: cubit.regularPrice,
                                              inputType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (cubit.scheduleDate != null)
                                    Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Sales price until :'),
                                              Text(AddProductCubit.get(context)
                                                  .formattedDate(
                                                      cubit.scheduleDate)),
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        if (cubit.editable == false)
                                          ElevatedButton(
                                            child: Text('Change date'),
                                            onPressed: () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          cubit.scheduleDate!,
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(5000))
                                                  .then((value) {
                                                setState(() {
                                                  cubit.scheduleDate = value;
                                                });
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.grey.shade400,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Size list',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        if (cubit.editable == false)
                                          TextButton(
                                            child: Text('Add list'),
                                            onPressed: () {
                                              setState(() {
                                                cubit.addList = true;
                                              });
                                            },
                                          )
                                      ]),
                                  if (cubit.addList)
                                    Form(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter a value';
                                              }
                                            },
                                            controller: cubit.sizeText,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white),
                                          )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                            child: Text('Add'),
                                            onPressed: () {
                                              if (cubit.formKey2.currentState!
                                                  .validate()) {
                                                cubit.sizeList
                                                    .add(cubit.sizeText.text);
                                                setState(() {
                                                  cubit.sizeText.clear();
                                                });
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                      key: cubit.formKey2,
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (cubit.sizeList.isNotEmpty)
                                    SizedBox(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cubit.sizeList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onLongPress: () {
                                                setState(() {
                                                  cubit.sizeList
                                                      .removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.amber,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                        cubit.sizeList[index])),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      height: 80,
                                    ),
                                ],
                              ),
                            ),
                          ),

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
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 20.0),
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
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, top: 20.0),
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
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, top: 20.0),
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
                          if (widget.product!.manageInventory == true)
                            Container(
                              color: Colors.grey.shade300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text('Manage inventory ?'),
                                        value: cubit.manageInventory,
                                        onChanged: (value) {
                                          setState(() {
                                            cubit.manageInventory = value;
                                            if (value == false) {
                                              cubit.soh.clear();
                                              cubit.reOrderLevel.clear();
                                            }
                                          });
                                        }),
                                    if (cubit.manageInventory == true)
                                      Row(children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                'SOH : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Expanded(
                                                child: CustomTextFormField(
                                                  controller: cubit.soh,
                                                  inputType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                'Re-Order Level : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomTextFormField(
                                                  controller:
                                                      cubit.reOrderLevel,
                                                  inputType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.grey.shade300,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text('Charge Shipping ?'),
                                      value: cubit.chargeShipping,
                                      onChanged: (value) {
                                        setState(() {
                                          cubit.chargeShipping = value;
                                          if (value == false) {
                                            cubit.shippingCharge.clear();
                                          }
                                        });
                                      }),
                                  if (cubit.chargeShipping == true)
                                    Row(
                                      children: [
                                        Text(
                                          'Shipping Charge : ',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: CustomTextFormField(
                                            inputType: TextInputType.number,
                                            controller: cubit.shippingCharge,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 20.0),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
