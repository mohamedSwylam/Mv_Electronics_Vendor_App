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
    String? sku,
    String? mainCategory,
    String? brand,
    String? subCategory,
    DateTime? scheduleDate,
    bool? manageInventory,
    int? soh,
    int? reorderLevel,
    bool? chargeShipping,
    int? shippingCharge,
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
    if (sku!= null) {
      productData!['sku'] = sku;
    }
    if (manageInventory!= null) {
      productData!['manageInventory'] = manageInventory;
    }
    if (soh!= null) {
      productData!['soh'] = soh;
    }
    if (reorderLevel!= null) {
      productData!['reorderLevel'] = reorderLevel;
    }
    if (chargeShipping!= null) {
      productData!['chargeShipping'] = chargeShipping;
    }
    if (shippingCharge!= null) {
      productData!['shippingCharge'] = shippingCharge;
    }
    if (brand!= null) {
      productData!['brand'] = brand;
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
  bool? manageInventory =false;
  manageInventoryChange(value){
    manageInventory=value;
    getFormData(
      manageInventory: value,
    );
    emit(ManageInventoryChangeSuccessState());
  }
  bool? chargeShipping =false;
  chargeShippingChange(value){
    chargeShipping=value;
    getFormData(
      chargeShipping: value,
    );
    emit(ChargeShippingChangeSuccessState());
  }
}