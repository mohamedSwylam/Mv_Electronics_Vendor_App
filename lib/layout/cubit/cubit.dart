import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/layout/cubit/states.dart';
import 'package:mv_vendor_app/models/vendor_model.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';

class AppCubit extends Cubit<AppStates>  {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  FirebaseService service=FirebaseService();
  DocumentSnapshot? doc;
  QuerySnapshot? snapshot;
  Vendor? vendor;
  getVendorData() {
    emit(GetVendorLoadingStates());
    service.vendor.doc(service.user!.uid).get().then((document) {
      doc = document;
     vendor= Vendor. fromJson(document.data() as Map<String, dynamic>);
      emit(GetVendorSuccessStates());
    }).catchError((error){
      emit(GetVendorErrorStates(error.toString()));
    });
  }
  
}