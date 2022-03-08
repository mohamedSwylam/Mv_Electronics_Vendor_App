import 'package:flutter/material.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';

class CategoryDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AddProductCubit.get(context);
    return DropdownButtonFormField<String>(
      value: cubit.selectedCategory,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
      onChanged: (value)=>cubit.dropDownButtonChange(value),
      hint: Text('Select Category',style: TextStyle(fontSize: 16),),
    items: cubit.categories
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    validator: (value){
    return 'Select category';
      }
    );

  }
}
