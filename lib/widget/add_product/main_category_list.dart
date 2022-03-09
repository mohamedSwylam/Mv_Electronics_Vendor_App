import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';

import '../../modules/add_products_screen/cubit/cubit.dart';

class MainCategoryList extends StatelessWidget {
  final String?   selectedCategory;

  const MainCategoryList({Key? key, this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var cubit = AddProductCubit.get(context);
    return Dialog(
      child: FutureBuilder<QuerySnapshot>(
          future: service.mainCategories
              .where('category', isEqualTo: selectedCategory)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.size == 0) {
              return Center(
                child: Text('No Main categories'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (contet, index) {
                  return ListTile(
                    title: Text(snapshot.data!.docs[index]['mainCategory'],),
                    onTap: (){
                      cubit.getFormData(
                        mainCategory: snapshot.data!.docs[index]['mainCategory']
                      );
                      Navigator.pop(context);
                    },
                  );
                });
          }),
    );
  }
}
