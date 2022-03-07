import 'package:flutter/material.dart';
import 'package:mv_vendor_app/shared/components/custom_text_field.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';

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
        ],
      ),
    );
  }
}
