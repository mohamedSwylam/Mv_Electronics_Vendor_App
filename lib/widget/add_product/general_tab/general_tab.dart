import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/shared/components/custom_text_field.dart';
import 'package:mv_vendor_app/widget/add_product/category_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/sub_category_list.dart';
import 'package:mv_vendor_app/widget/add_product/tax_amount_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/tax_status_drop_down.dart';

import '../../../modules/add_products_screen/cubit/cubit.dart';
import '../../../modules/add_products_screen/cubit/states.dart';
import '../../../services/firebase_service.dart';
import '../main_category_list.dart';

class GeneralTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AddProductCubit.get(context);
    FirebaseService service = FirebaseService();
    return BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AddProductCubit.get(context);
          FirebaseService service = FirebaseService();
         return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                CustomTextFormField(
                  labelText: 'Enter product name',
                  inputType: TextInputType.name,
                  onChanged: (value) {
                    cubit.getFormData(
                      productName: value,
                    );
                  },
                ),
                CustomTextFormField(
                  labelText: 'Enter Description',
                  inputType: TextInputType.multiline,
                  maxLine: 10,
                  minLine: 2,
                  onChanged: (value) {
                    cubit.getFormData(
                      description: value,
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                CategoryDropDown(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cubit.productData!['mainCategory'] == null
                            ? 'Select main Category'
                            : cubit.productData!['mainCategory']!,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      if (cubit.selectedCategory != null)
                        InkWell(
                          child: Icon(Icons.arrow_drop_down),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MainCategoryList(
                                    selectedCategory: cubit.selectedCategory,
                                  );
                                }).whenComplete(() {
                              cubit.doSetState();
                            });
                          },
                        ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cubit.productData!['subCategory'] == null
                            ? 'Select Sub Category'
                            : cubit.productData!['subCategory']!,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      if (cubit.productData!['mainCategory'] != null)
                        InkWell(
                          child: Icon(Icons.arrow_drop_down),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SubCategoryList(
                                    selectedMainCategory:
                                        cubit.productData!['mainCategory'],
                                  );
                                }).whenComplete(() {
                              cubit.doSetState();
                            });
                          },
                        ),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  labelText: 'Regular Price (\$)',
                  inputType: TextInputType.number,
                  onChanged: (value) {
                    cubit.getFormData(
                      regularPrice: int.parse(value),
                    );
                  },
                ),
                CustomTextFormField(
                  labelText: 'Sales Price (\$)',
                  inputType: TextInputType.number,
                  onChanged: (value) {
                    if(int.parse(value)>cubit.productData! ['regularPrice']){
                    cubit.scaffold('Sales price should be less than regular price',context);
                    return;}
                    cubit.getFormData(
                      salesPrice: int.parse(value),
                    );
                  },
                ),
                if (cubit.salePrice)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(5000),
                          ).then((value) {
                            cubit.getFormData(
                              scheduleDate: value,
                            );
                          });
                        },
                        child: Text(
                          'Schedule',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      if (cubit.productData!['scheduleDate'] != null)
                        Text(cubit
                            .formattedDate(cubit.productData!['scheduleDate'])),
                    ],
                  ),
                SizedBox(
                  height: 30,
                ),
                cubit.TaxStatusDropDown(),
                Divider(
                  color: Colors.black,
                ),
                if (cubit.taxStatus == 'Taxable')
                  cubit.TaxAmountDropDown(),
              ],
            ),
          );
        });
  }
}
