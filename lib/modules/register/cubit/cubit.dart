import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/modules/register/cubit/states.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
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
  String? emailNumber;

  onChangeEmail(value) {
    emailNumber = value;
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
    address = value;
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

  scaffold(message, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: message,));
  }
}