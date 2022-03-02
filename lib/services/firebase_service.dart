import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{
  CollectionReference homeBanners =FirebaseFirestore.instance.collection('homeBanners');
  CollectionReference categories =FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCategories =FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories =FirebaseFirestore.instance.collection('subCategories');
}