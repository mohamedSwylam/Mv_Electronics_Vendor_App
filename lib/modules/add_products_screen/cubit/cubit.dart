import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/modules/Login/cubit/states.dart';
import 'package:mv_vendor_app/modules/add_products_screen/cubit/states.dart';

import '../../../services/firebase_service.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);
  Map<String, dynamic>? productData = {};
  FirebaseService service = FirebaseService();

  getFormData({String? productName,
    int? regularPrice,
    int? salesPrice,
    String? taxStatus,
    String? category,
    String? mainCategory,
    String? subCategory,
    int? taxPercentage}) {
    if (productName != null) {
      productData!['productName'] = productName;
    }
    if (regularPrice != null) {
      productData!['regularPrice'] = regularPrice;
    }
    if (salesPrice != null) {
      productData!['salesPrice'] = salesPrice;
    }
    if (taxStatus != null) {
      productData!['taxStatus'] = taxStatus;
    }
    if (taxPercentage != null) {
      productData!['taxPercentage'] = taxPercentage;
    }
    if (category!= null) {
      productData!['category'] = category;
    }
    if (mainCategory!= null) {
      productData!['mainCategory'] = mainCategory;
    }
    if (subCategory!= null) {
      productData!['subCategory'] = subCategory;
    }
    emit(GetFormDataSuccessState());
  }

  List<String> categories = [];
  getCategories() {
    service.categories.get().then((value) {
      value.docs.forEach((element) {
        categories.add(element['catName']);
      });
      emit(GetCategoriesSuccessState());
    });
  }
  String? selectedCategory;
  String? mainCategory;
  bool noCategorySelected = false;
  void dropDownButtonChange(selectedCat) {
    selectedCategory = selectedCat;
    getFormData(
        category:selectedCat,
    );
    noCategorySelected=false;
    emit(OnCategoryNameChangeSuccessState());
  }
   doSetState() {
    emit(DoSetStateSuccessState());
  }
  String? taxStatus;
  int? taxAmount;
  void dropDownTaxStatusButtonChange(selectedStatus) {
    taxStatus = selectedStatus;
    getFormData(
      taxStatus: selectedStatus,
    );
    emit(OnTaxStatusChangeSuccessState());
  }
  void dropDownTaxAmountButtonChange(selectedAmount) {
    taxAmount = int.parse(selectedAmount);
    getFormData(
      taxPercentage: taxAmount == 'GST-10%'? 10 : 12,
    );
    emit(OnTaxAmountChangeSuccessState());
  }
}