import 'package:flutter/material.dart';
import 'package:mv_vendor_app/shared/components/custom_text_field.dart';
import 'package:mv_vendor_app/widget/add_product/category_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/sub_category_list.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';
import 'main_category_list.dart';

class GeneralTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AddProductCubit.get(context);
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
        SizedBox (height: 30,),
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
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                if(cubit.selectedCategory!=null)
                  InkWell(
                  child: Icon(Icons.arrow_drop_down),
                  onTap: (){
                    showDialog(context: context, builder: (context){
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
          Divider (color: Colors.black,),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cubit.productData!['subCategory'] == null
                      ? 'Select Sub Category'
                      : cubit.productData!['subCategory']!,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                if(cubit.productData!['mainCategory']!=null)
                  InkWell(
                  child: Icon(Icons.arrow_drop_down),
                  onTap: (){
                    showDialog(context: context, builder: (context){
                    return SubCategoryList(
                    selectedMainCategory: cubit.productData!['mainCategory'],
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
          SizedBox (height: 30,),
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
              cubit.getFormData(
                regularPrice: int.parse(value),
              );
            },
          ),
          SizedBox (height: 30,),
        ],
      ),
    );
  }
}
