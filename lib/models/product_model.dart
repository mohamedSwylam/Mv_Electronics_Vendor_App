import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mv_vendor_app/services/firebase_service.dart';

class Product {
  final String? productName;
  final int? regularPrice;
  final int? salesPrice;
  final String? taxStatus;
  final String? category;
  final String? description;
  final String? sku;
  final String? otherDetails;
  final String? mainCategory;
  final String? brand;
  final String? subCategory;
  final String? unit;
  final Timestamp? scheduleDate;
  final bool? manageInventory;
  final bool? approved;
  final int? soh;
  final int? reorderLevel;
  final bool? chargeShipping;
  final int? shippingCharge;
  final List? size;
  final List? imageUrls;
  final Map<String, dynamic>? seller;
  final double? taxPercentage;

  Product(
      {this.productName,
      this.regularPrice,
      this.salesPrice,
      this.taxStatus,
      this.category,
      this.description,
      this.sku,
      this.otherDetails,
      this.mainCategory,
      this.brand,
      this.subCategory,
      this.unit,
      this.scheduleDate,
      this.manageInventory,
      this.soh,
      this.reorderLevel,
      this.chargeShipping,
      this.shippingCharge,
      this.size,
      this.imageUrls,
      this.approved,
      this.seller,
      this.taxPercentage});

  Product.fromJson(Map<String, Object?> json)
      : this(
          productName: json['productName']! as String,
          regularPrice: json['regularPrice']! as int,
          salesPrice: json['salesPrice']! as int,
          taxStatus: json['taxStatus']! as String,
          category: json['category']! as String,
          description: json['description'] == null
              ? null
              : json['description']! as String,
          sku: json['sku'] == null ? null : json['sku']! as String,
          otherDetails: json['otherDetails'] == null
              ? null
              : json['otherDetails']! as String,
          brand: json['brand'] == null ? null : json['brand'] as String,
          unit: json['unit'] == null ? null : json['unit']! as String,
          mainCategory: json['mainCategory'] == null
              ? null
              : json['mainCategory']! as String,
          subCategory: json['subCategory'] == null
              ? null
              : json['subCategory']! as String,
          scheduleDate: json['scheduleDate'] == null
              ? null
              : json['scheduleDate']! as Timestamp,
          manageInventory: json['manageInventory'] == null
              ? null
              : json['manageInventory']! as bool,
          approved: json['approved']! as bool,
          soh: json['soh'] == null ? null : json['soh']! as int,
          reorderLevel: json['reorderLevel'] == null
              ? null
              : json['reorderLevel']! as int,
          chargeShipping: json['chargeShipping'] == null
              ? null
              : json['chargeShipping']! as bool,
          shippingCharge: json['shippingCharge'] == null
              ? null
              : json['shippingCharge']! as int,
          size: json['size'] == null ? null : json['size']! as List,
          imageUrls: json['imageUrls']! as List,
          seller: json['seller']! as Map<String, dynamic>,
          taxPercentage: json['taxPercentage'] == null
              ? null
              : json['taxPercentage']! as double,
        );

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'approved': approved,
      'regularPrice': regularPrice,
      'salesPrice': salesPrice,
      'taxStatus': taxStatus,
      'category': category,
      'description': description,
      'sku': sku,
      'otherDetails': otherDetails,
      'mainCategory': mainCategory,
      'brand': brand,
      'subCategory': subCategory,
      'unit': unit,
      'scheduleDate': scheduleDate,
      'manageInventory': manageInventory,
      'soh': soh,
      'reorderLevel': reorderLevel,
      'chargeShipping': chargeShipping,
      'shippingCharge': shippingCharge,
      'size': size,
      'imageUrls': imageUrls,
      'seller': seller,
      'taxPercentage': taxPercentage,
    };
  }
}

FirebaseService service = FirebaseService();

productQuery(approved) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .where('seller.uid', isEqualTo: service.user!.uid)
      .orderBy('productName')
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
