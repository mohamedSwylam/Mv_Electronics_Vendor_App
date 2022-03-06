import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/layout/cubit/states.dart';
import 'package:mv_vendor_app/modules/account_screen/account_screen.dart';
import 'package:mv_vendor_app/modules/categoryy_screen/category_screen.dart';
import 'package:mv_vendor_app/modules/chat_screen/chat_screen.dart';
import 'package:mv_vendor_app/modules/home_screen/home_screen.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';




class AppCubit extends Cubit<AppStates>  {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  FirebaseService service=FirebaseService();
  DocumentSnapshot? doc;
  getVendorData() {
    emit(GetVendorLoadingStates());
    service.vendor.doc(service.user!.uid).get().then((document) {
      doc = document;
      emit(GetVendorSuccessStates());
    }).catchError((error){
      emit(GetVendorErrorStates());
    });
  }
}