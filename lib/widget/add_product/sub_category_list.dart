import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';

class SubCategoryList extends StatelessWidget {
  final String?   selectedMainCategory;

  const SubCategoryList({Key? key, this.selectedMainCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var cubit = AddProductCubit.get(context);
    return Dialog(
      child: FutureBuilder<QuerySnapshot>(
          future: service.subCategories
              .where('mainCategory', isEqualTo: selectedMainCategory)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.size == 0) {
              return Center(
                child: Text('No Sub categories'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.docs[index]['subCatName'],),
                    onTap: (){
                      cubit.getFormData(
                        subCategory: snapshot.data!.docs[index]['subCatName']
                      );
                      Navigator.pop(context);
                    },
                  );
                });
          }),
    );
  }
}
