import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/modules/Login/cubit/states.dart';
import 'package:mv_vendor_app/modules/add_products_screen/cubit/states.dart';
import 'package:intl/intl.dart';
import '../../../services/firebase_service.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);
  Map<String, dynamic>? productData = {};
  FirebaseService service = FirebaseService();
  bool salePrice=false;

  getFormData({String? productName,
    int? regularPrice,
    int? salesPrice,
    String? taxStatus,
    String? category,
    String? description,
    String? mainCategory,
    String? subCategory,
    DateTime? scheduleDate,
    double? taxPercentage}) {
    if (productName != null) {
      productData!['productName'] = productName;
    }
    if (regularPrice != null) {
      productData!['regularPrice'] = regularPrice;
    }
    if (salesPrice != null) {
      productData!['salesPrice'] = salesPrice;
      salePrice=true;
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
    if (description!= null) {
      productData!['description'] = description;
    }
    if (scheduleDate!= null) {
      productData!['scheduleDate'] = scheduleDate;
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
  void dropDownButtonChange(String? selectedCat) {
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
  String? taxAmount;
  void dropDownTaxStatusButtonChange(String? selectedStatus) {
    taxStatus = selectedStatus;
    getFormData(
      taxStatus: selectedStatus,
    );
    emit(OnTaxStatusChangeSuccessState());
  }
  void dropDownTaxAmountButtonChange(String? selectedAmount) {
    taxAmount = selectedAmount;
    getFormData(
      taxPercentage: taxAmount == 'GST-10%'? 10 : 12,
    );
    emit(OnTaxAmountChangeSuccessState());
  }
  String formattedDate(date){
    var outputFormat = DateFormat('dd/MM/yyyy hh:mn aa');
    var outputDate = outputFormat.format(date);
    return outputDate;
  }
}