import 'package:flutter/material.dart';
import 'package:mv_vendor_app/shared/components/custom_text_field.dart';

class GeneralTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          CustomTextFormField(
            labelText: 'Enter product name',
            inputType: TextInputType.name,
          ),
        ],
      ),
    );
  }
}
