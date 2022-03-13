import 'package:flutter/material.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';

class UnitDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AddProductCubit.get(context);
    return DropdownButtonFormField<String>(
        value: cubit.selectedUnit,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (value)=>cubit.dropDownUnitButtonChange(value),
        hint: Text('Select Unit',style: TextStyle(fontSize: 16),),
        items: cubit.units
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value){
    if(value!.isEmpty) {
      return 'Select Unit';
    }
        }
    );

  }
}
