import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/shared/components/custom_text_field.dart';
import 'package:mv_vendor_app/widget/add_product/category_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/sub_category_list.dart';
import 'package:mv_vendor_app/widget/add_product/tax_amount_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/tax_status_drop_down.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';
import '../../modules/add_products_screen/cubit/states.dart';
import '../../services/firebase_service.dart';
import 'main_category_list.dart';

class AttributesTab extends StatelessWidget {
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
                    labelText: 'Brand',
                    inputType: TextInputType.text,
                    onChanged: (value) {
                      cubit.getFormData(
                        shippingCharge: int.parse(value),
                      );
                    },
                  ),
                ]
            ),
          );
        });
  }
}
