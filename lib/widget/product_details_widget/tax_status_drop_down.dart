import 'package:flutter/material.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';
import '../../modules/product_details_screen/cubit/cubit.dart';

class TaxStatusDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ProductDetailsCubit.get(context);
    return DropdownButtonFormField<String>(
        value: cubit.taxStatus,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (value)=>cubit.dropDownTaxStatusButtonChange(value),
        hint: Text('Tax Status',style: TextStyle(fontSize: 16),),
        items: ['Taxable', 'Not Taxable']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value){
          if(value!.isEmpty) {
            return 'Select Tax Status';
          }
        }
    );

  }
}
