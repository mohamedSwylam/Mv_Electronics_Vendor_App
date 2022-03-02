import 'package:mv_vendor_app/services/firebase_service.dart';


class SubCategory {
  SubCategory({required this.image, required this.mainCategory,required this.subCatName});

  SubCategory.fromJson(Map<String, Object?> json)
      : this(
    image: json['image']! as String,
    subCatName: json['subCatName']! as String,
    mainCategory: json['mainCategory']! as String,
  );

  final String image;
  final String subCatName;
  final String mainCategory;

  Map<String, Object?> toJson() {
    return {
      'image': image,
      'subCatName': subCatName,
      'mainCategory': mainCategory,
    };
  }
}
FirebaseService service=FirebaseService();
 subCategoryCollection (selectedCat){
  return service.subCategories.where('active',isEqualTo: true).where('mainCategory',isEqualTo: selectedCat).withConverter<SubCategory>(
      fromFirestore: (snapshot, _) => SubCategory.fromJson(snapshot.data()!),
   toFirestore: (subCategory, _) => subCategory.toJson(),);
 }