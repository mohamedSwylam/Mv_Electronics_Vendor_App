import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:mv_vendor_app/layout/cubit/cubit.dart';
import 'package:mv_vendor_app/modules/add_products_screen/cubit/cubit.dart';

class FirebaseService {
  CollectionReference homeBanners =
  FirebaseFirestore.instance.collection('homeBanners');
  CollectionReference categories =
  FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCategories =
  FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories =
  FirebaseFirestore.instance.collection('subCategories');
  CollectionReference vendor = FirebaseFirestore.instance.collection('vendor');
  CollectionReference product = FirebaseFirestore.instance.collection(
      'product');
  User? user = FirebaseAuth.instance.currentUser;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadImage(XFile? file, String? reference) async {
    File _file = File(file!.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref(reference);
    await ref.putFile(_file);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> addVendor({Map<String, dynamic>? data}) {
    return vendor
        .doc(user!.uid)
        .set(data)
        .then((value) => print("Vendor Added"))
        .catchError((error) => print("Failed to add Vendor: $error"));
  }

  Future<List> uploadFiles(List<XFile>? images, String? ref,context) async {
    var imageUrls = await Future.wait(
        images!.map(
              (image) => uploadFile(image: File(image.path), reference: ref),
        ),);
    AddProductCubit.get(context).getFormData(
      imageUrls: imageUrls
    );
    return imageUrls;
  }

  Future uploadFile({File? image, String? reference,}) async {
    firebase_storage.Reference storageReference = storage.ref().child(
        reference!);

    firebase_storage.UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    return storageReference.getDownloadURL();
  }
}
