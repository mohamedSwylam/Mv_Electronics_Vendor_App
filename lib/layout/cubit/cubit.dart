import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_vendor_app/layout/cubit/states.dart';
import 'package:mv_vendor_app/modules/account_screen/account_screen.dart';
import 'package:mv_vendor_app/modules/cart_screen/cart_screen.dart';
import 'package:mv_vendor_app/modules/categoryy_screen/category_screen.dart';
import 'package:mv_vendor_app/modules/chat_screen/chat_screen.dart';
import 'package:mv_vendor_app/modules/home_screen/home_screen.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';




class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  FirebaseService service=FirebaseService();
  //onBoarding
  //pageView on home screen
  double scrollPositionBanner = 0;
 void pageViewBannerChange(value){
   scrollPositionBanner = value.toDouble();
   emit(ChangePageViewState());
 }
  double scrollPositionBrand = 0;
  void pageViewBrandsChange(value){
    scrollPositionBrand = value.toDouble();
    emit(ChangePageViewState());
  }
  //Button navigation bar
  int currentIndex = 0;
  List<Widget> StoreScreens = [
    HomeScreen(),
    CategoryScreen(),
    ChatScreen(),
    CartScreen(),
    UserScreen(),
  ];

  void selectedHome() {
    currentIndex = 0;
    emit(ChangeBottomNavState());
  }
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
  void selectCart() {
    currentIndex = 2;
    emit(ChangeBottomNavState());
  }

  void selectChat() {
    currentIndex = 1;
    emit(ChangeBottomNavState());
  }

  void selectUser() {
    currentIndex = 3;
    emit(ChangeBottomNavState());
  }
  //category widget
  String? selectedCategory;
  void changeCategoryLabel(value) {
    selectedCategory = value;
    emit(ChangeCategoryLabelState());
  }
  // get homeBanners
  List banners = [];
   getBanners() async {
    emit(GetBannersLoadingStates());
    await FirebaseFirestore.instance.collection('homeBanners')
        .get()
        .then((QuerySnapshot bannersSnapshot) {
      bannersSnapshot.docs.forEach((element) {
        banners.add(element['image']);
      });
      emit(GetBannersSuccessStates());
    }).catchError((error) {
      emit(GetBannersErrorStates(error.toString()));
    });
  }
  // get homeBanners
  List brandAd = [];
  getBrandsAd() async {
    emit(GetBrandAdLoadingStates());
    await FirebaseFirestore.instance.collection('brandAd')
        .get()
        .then((QuerySnapshot brandAdSnapshot) {
      brandAdSnapshot.docs.forEach((element) {
        brandAd.add(element);
      });
      emit(GetBrandAdSuccessStates());
    }).catchError((error) {
      emit(GetBrandAdErrorStates(error.toString()));
    });
  }
}