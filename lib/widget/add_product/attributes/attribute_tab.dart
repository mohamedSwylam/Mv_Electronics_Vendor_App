import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/shared/components/custom_text_field.dart';
import 'package:mv_vendor_app/widget/add_product/category_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/sub_category_list.dart';
import 'package:mv_vendor_app/widget/add_product/tax_amount_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/tax_status_drop_down.dart';
import 'package:mv_vendor_app/widget/add_product/unit_dropdown.dart';

import '../../../modules/add_products_screen/cubit/cubit.dart';
import '../../../modules/add_products_screen/cubit/states.dart';
import '../../../services/firebase_service.dart';
import '../main_category_list.dart';

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
            child: ListView(children: [
              CustomTextFormField(
                labelText: 'Brand',
                inputType: TextInputType.text,
                onChanged: (value) {
                  cubit.getFormData(
                    shippingCharge: int.parse(value),
                  );
                },
              ),
              UnitDropDown(),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cubit.sizeText,
                      decoration: const InputDecoration(
                        label: Text('Size'),
                      ),
                      onChanged: (value) => cubit.onchangeSize(value),
                    ),
                  ),
                  if (cubit.entered!)
                    ElevatedButton(
                      child: Text('Add'),
                      onPressed: () => cubit.addSize(),
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (cubit.sizeList.isNotEmpty)
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.sizeList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onLongPress: () {
                              cubit.removeSize(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.orange.shade500,
                              ),
                              height: 50,
                              width: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    cubit.sizeList[index],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              if(cubit.sizeList.isNotEmpty)
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '* Long press to delete',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(cubit.saved == true ? 'Saved' : 'Press To Save'),
                          onPressed: () {
                            cubit.getFormData(
                              sizeList: cubit.sizeList,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CustomTextFormField(
                labelText: 'Add other details',
                inputType: TextInputType.text,
                maxLine: 2,
                onChanged: (value) {
                  cubit.getFormData(
                    otherDetails: value,
                  );
                },
              ),
            ]),
          );
        });
  }
}
