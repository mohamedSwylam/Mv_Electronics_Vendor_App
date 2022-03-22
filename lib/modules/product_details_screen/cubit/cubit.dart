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
  String? taxStatus;
  String? taxAmount;
  void dropDownTaxStatusButtonChange(String? selectedStatus) {
    taxStatus = selectedStatus;
    emit(TaxStatusChangeSuccessState());
  }
  void dropDownTaxAmountButtonChange(String? selectedAmount) {
    taxAmount = selectedAmount;
    emit(TaxAmountChangeSuccessState());
  }
}
