import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mv_vendor_app/modules/register/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mv_vendor_app/widget/landing_screen.dart';

import '../../../services/firebase_service.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  FirebaseService service = FirebaseService();
  final formKey = GlobalKey<FormState>();
  TextEditingController? businessNameController;
  String? businessName;

  onChangeBusinessName(value) {
    businessName = value;
    emit(OnChangeBusinessNameState());
  }

  TextEditingController? contactNumberController;
  String? contactNumber;

  onChangeContactNumber(value) {
    contactNumber = value;
    emit(OnChangeContactNumberState());
  }

  TextEditingController? emailController;
  String? emailAddress;

  onChangeEmail(value) {
    emailAddress = value;
    emit(OnChangeEmailState());
  }

  TextEditingController? gstNumberController;
  String? gstNumber;

  onChangeGstNumber(value) {
    gstNumber = value;
    emit(OnChangeGstNumberState());
  }

  TextEditingController? pinCodeController;
  String? pinCode;

  onChangePinCode(value) {
    pinCode = value;
    emit(OnChangePinCodeState());
  }

  TextEditingController? addressController;
  String? address;

  onChangeAddress(value) {
    address = value;
    emit(OnChangeAddressState());
  }

  TextEditingController? cityController;
  String? city;

  onChangeCity(value) {
    city = value;
    emit(OnChangeCityState());
  }

  TextEditingController? countryController;
  String? country;

  onChangeCountry(value) {
    country = value;
    emit(OnChangeCountryState());
  }

  TextEditingController? landMarkController;
  String? landMark;

  onChangeLandMark(value) {
    landMark = value;
    emit(OnChangeLandMark());
  }

  TextEditingController? stateController;
  String? statee;

  onChangeState(value) {
    statee = value;
    emit(OnChangeState());
  }

  String? taxStatus;

  onChangeTaxRegistered(value) {
    taxStatus = value;
    emit(OnChangeTaxRegisteredState());
  }

  final ImagePicker picker = ImagePicker();
  XFile? shopImage;
  XFile? logoShopImage;

  Future<XFile?> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  pickShopImage() {
    pickImage().then((value) {
      shopImage = value;
      emit(PickShopImageSuccessState());
    }).catchError((error) {
      emit(PickShopImageErrorState(error.toString()));
    });
  }

  pickLogoShopImage() {
    pickImage().then((value) {
      logoShopImage = value;
      emit(PickShopImageSuccessState());
    }).catchError((error) {
      emit(PickShopImageErrorState(error.toString()));
    });
  }

  String? shopImageUrl;
  String? shopLogoUrl;

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

  saveToDb(context) {
    if (shopImage == null) {
      scaffold('Shop Image not selected', context);
      return;
    }
    if (logoShopImage == null) {
      scaffold('Shop Logo not selected', context);
      return;
    }
    if (formKey.currentState!.validate()) {
      if (country == null || city == null || statee == null) {
        scaffold('Selected address field completely', context);
        return;
      }
      EasyLoading.show(status: 'Please wait..');
      service
          .uploadImage(shopImage, 'vendors/${service.user!.uid}/shopImage.jpg')
          .then((String? url) {
        if (url != null) {
          shopImageUrl = url;
          emit(SaveToDbSuccessState());
        }
      }).then((value) {
        service
            .uploadImage(logoShopImage, 'vendors/${service.user!.uid}/logo.jpg')
            .then((String? url) {
          if (url != null) {
            shopLogoUrl = url;
            emit(SaveToDbSuccessState());
          }
          emit(SaveToDbSuccessState());
        }).then((value) {
          service.addVendor(data: {
            'shopImage': shopImageUrl,
            'Logo': shopLogoUrl,
            'businessName': businessName,
            'mobile': '+2${contactNumber}',
            'email': emailAddress,
            'taxRegistered': taxStatus,
            'tinNumber': gstNumber == null ? null : gstNumber,
            'pinCode': pinCode,
            'LandMark': landMark,
            'country': country,
            'state': statee,
            'approved': false,
            'city': city,
            'uid': service.user!.uid,
            'time': DateTime.now(),
          });
          emit(SaveToDbSuccessState());
        }).then((value) {
          EasyLoading.dismiss();
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => LandingScreen(),
            ),
          );
        }).catchError((error) {
          emit(SaveToDbErrorState(error.toString()));
        });
      });
    }
  }
}
