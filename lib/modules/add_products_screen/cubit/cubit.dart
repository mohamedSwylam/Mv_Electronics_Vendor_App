import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mv_vendor_app/modules/Login/cubit/states.dart';
import 'package:mv_vendor_app/modules/add_products_screen/cubit/states.dart';
import 'package:intl/intl.dart';
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


class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);
  Map<String, dynamic>? productData = {
    'approved':false
  };
  FirebaseService service = FirebaseService();
  bool salePrice = false;

  getFormData(
      {String? productName,
      int? regularPrice,
      int? salesPrice,
      String? taxStatus,
      String? category,
      String? description,
      String? sku,
      String? otherDetails,
      String? mainCategory,
      String? brand,
      String? subCategory,
      String? unit,
      DateTime? scheduleDate,
      bool? manageInventory,
      int? soh,
      int? reorderLevel,
      bool? chargeShipping,
      int? shippingCharge,
      List? sizeList,
      double? taxPercentage}) {
    if (productName != null) {
      productData!['productName'] = productName;
    }
    if (unit != null) {
      productData!['unit'] = unit;
    }
    if (regularPrice != null) {
      productData!['regularPrice'] = regularPrice;
    }
    if (salesPrice != null) {
      productData!['salesPrice'] = salesPrice;
      salePrice = true;
    }
    if (taxStatus != null) {
      productData!['taxStatus'] = taxStatus;
    }
    if (otherDetails != null) {
      productData!['otherDetails'] = otherDetails;
    }
    if (taxPercentage != null) {
      productData!['taxPercentage'] = taxPercentage;
    }
    if (category != null) {
      productData!['category'] = category;
    }
    if (mainCategory != null) {
      productData!['mainCategory'] = mainCategory;
    }
    if (subCategory != null) {
      productData!['subCategory'] = subCategory;
    }
    if (description != null) {
      productData!['description'] = description;
    }
    if (scheduleDate != null) {
      productData!['scheduleDate'] = scheduleDate;
    }
    if (sku != null) {
      productData!['sku'] = sku;
    }
    if (manageInventory != null) {
      productData!['manageInventory'] = manageInventory;
    }
    if (soh != null) {
      productData!['soh'] = soh;
    }
    if (reorderLevel != null) {
      productData!['reorderLevel'] = reorderLevel;
    }
    if (chargeShipping != null) {
      productData!['chargeShipping'] = chargeShipping;
    }
    if (shippingCharge != null) {
      productData!['shippingCharge'] = shippingCharge;
    }
    if (brand != null) {
      productData!['brand'] = brand;
    }
    if (sizeList != null) {
      productData!['size'] = sizeList;
      saved = true;
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
      category: selectedCat,
    );
    noCategorySelected = false;
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
      taxPercentage: taxAmount == 'GST-10%' ? 10 : 12,
    );
    emit(OnTaxAmountChangeSuccessState());
  }

  String formattedDate(date) {
    var outputFormat = DateFormat('dd/MM/yyyy hh:mn aa');
    var outputDate = outputFormat.format(date);
    return outputDate;
  }

  bool? manageInventory = false;

  manageInventoryChange(value) {
    manageInventory = value;
    getFormData(
      manageInventory: value,
    );
    emit(ManageInventoryChangeSuccessState());
  }

  bool? chargeShipping = false;

  chargeShippingChange(value) {
    chargeShipping = value;
    getFormData(
      chargeShipping: value,
    );
    emit(ChargeShippingChangeSuccessState());
  }

  final sizeText = TextEditingController();
  List<String> sizeList = [];

  addSize() {
    sizeList.add(sizeText.text);
    sizeText.clear();
    entered = false;
    saved = false;
    emit(AddSizeSuccessState());
  }

  removeSize(index) {
    sizeList.removeAt(index);
    getFormData(
      sizeList: sizeList,
    );
    emit(RemoveSizeSuccessState());
  }

  onchangeSize(value) {
    if (value.isNotEmpty) {
      entered = true;
      emit(OnChangeSizeSuccessState());
    }
  }

  bool? saved = false;
  bool? entered = false;
  String? selectedUnit;
  final List<String> units = ['Kg', 'Gra', 'Liter', 'Nos', 'Feet', 'Yard', 'Set'];

  void dropDownUnitButtonChange(String? selectedUnit) {
    selectedUnit = selectedUnit;
    getFormData(
      unit: selectedUnit,
    );
    noCategorySelected = false;
    emit(ChangedropDownUnitButtonChange());
  }
  dynamic image;
  String? fileName;
  String? url;
  final formKey = GlobalKey<FormState>();
  final TextEditingController catName = TextEditingController();

  final ImagePicker picker = ImagePicker();
  List<XFile>? imageFiles=[];
  Future<List<XFile>?> pickImage() async {
    final List<XFile>? images= await picker.pickMultiImage().then((value) {
      var list = value!.forEach((element) {
          imageFiles!.add(element);
          emit(PickedImageSuccessState());
      });
    }).catchError((error) {
      emit(PickedImageErrorState(error.toString()));
    });
  }
  removeImage(index){
    imageFiles!.removeAt(index);
    emit(RemoveImageSuccessState());
  }
  scaffold(message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
      ),
    );
  }
 saveImageToDb() async {
    EasyLoading.show();
    var ref = firebase_storage.FirebaseStorage.instance
        .ref('categoryImage/$fileName');
    try {
      String? mimiType = mime(
        basename(fileName!),
      );
      var metaData = firebase_storage.SettableMetadata(contentType: mimiType);
      firebase_storage.TaskSnapshot uploadSnapshot =
      await ref.putData(image, metaData);
      await ref.putData(image); //now image will upload to firebase storage.
      //now need to get the download link of that image to save in fireStore
      String downloadURL =
      await uploadSnapshot.ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          url = value;
          service.saveCategory(
            data: {
              'catName': catName.text,
              'image': '$value.png',
              'active': true,
            },
            docName: catName.text,
            reference: service.categories,
          ).then((value) {
            clear();
            EasyLoading.dismiss();
          });
        }
        emit(SaveImageToDbSuccessState());
        //save data to firestore
        return value;
      });
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      emit(SaveImageToDbErrorState(e.toString()));
    }
  }

}
