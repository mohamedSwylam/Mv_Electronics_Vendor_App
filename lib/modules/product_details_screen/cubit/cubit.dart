import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mv_vendor_app/modules/Login/cubit/states.dart';
import 'package:mv_vendor_app/modules/add_products_screen/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:mv_vendor_app/modules/product_details_screen/cubit/states.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../models/product_model.dart';
import '../../../services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);
  FirebaseService service = FirebaseService();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final productName = TextEditingController();
  final brand = TextEditingController();
  final salesPrice = TextEditingController();
  final regularPrice = TextEditingController();
  final description = TextEditingController();
  final soh = TextEditingController();
  final reOrderLevel = TextEditingController();
  final shippingCharge = TextEditingController();
  final otherDetails = TextEditingController();
  final sizeText = TextEditingController();
  DateTime? scheduleDate;
  String? taxStatus;
  String? taxAmount;
  bool? manageInventory;
  bool? chargeShipping;
  bool addList = true;
  List sizeList = [];

  getProductData(Product product) {
    productName.text = product.productName!;
    description.text = product.description!;
    otherDetails.text = product.otherDetails!;
    brand.text = product.brand!;
    salesPrice.text = product.salesPrice!.toString();
    regularPrice.text = product.regularPrice!.toString();
    soh.text = product.soh!.toString();
    shippingCharge.text = product.shippingCharge!.toString();
    reOrderLevel.text = product.reorderLevel!.toString();
    taxStatus = product.taxStatus!;
    taxAmount = product.taxPercentage == 10 ? 'GST-10%' : 'GST-12%';
    if (product.scheduleDate != null) {
      scheduleDate = DateTime.fromMicrosecondsSinceEpoch(
          product.scheduleDate!.microsecondsSinceEpoch);
    }
    if (product.size!.isNotEmpty) {
      sizeList = product.size!;
    }
    manageInventory = product.manageInventory;
    chargeShipping = product.chargeShipping;
  }

  void dropDownTaxStatusButtonChange(String? selectedStatus) {
    taxStatus = selectedStatus;

    emit(TaxStatusChangeSuccessState());
  }

  void dropDownTaxAmountButtonChange(String? selectedAmount) {
    taxAmount = selectedAmount;
    emit(TaxAmountChangeSuccessState());
  }

  Widget taxStatusDropDown() {
    return DropdownButtonFormField<String>(
        value: taxStatus,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (value) => dropDownTaxStatusButtonChange(value),
        hint: Text(
          'Tax Status',
          style: TextStyle(fontSize: 16),
        ),
        items: ['Taxable', 'Not Taxable']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Select Tax Status';
          }
        });
  }

  Widget taxAmountDropDown() {
    return DropdownButtonFormField<String>(
        value: taxAmount,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (value) => dropDownTaxAmountButtonChange(value),
        hint: Text(
          'Tax Amount',
          style: TextStyle(fontSize: 16),
        ),
        items: ['GST-10%', 'GST-12%']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Select Tax Amount';
          }
        });
  }

  bool editable = true;

  changeToEdit() {
    editable = false;
    emit(ChangeToEditSuccessState());
  }

  changeToSave(productId) {
    EasyLoading.show();
    service.products.doc(productId).update({
      'brand': brand.text,
      'productName' : productName.text,
      'description': description,
    });
    if (formKey.currentState!.validate()) {
      editable = true;
      addList = false;
      emit(ChangeToEditSuccessState());
    }
  }
}
