import 'package:cloud_firestore/cloud_firestore.dart';

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
  final DateTime? scheduleDate;
  final bool? manageInventory;
  final int? soh;
  final int? reorderLevel;
  final bool? chargeShipping;
  final int? shippingCharge;
  final List? sizeList;
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
      this.sizeList,
      this.imageUrls,
      this.seller,
      this.taxPercentage});

  Product.fromJson(Map<String, Object?> json)
      : this(
          productName: json['productName']! as String,
          regularPrice: json['regularPrice']! as int,
          salesPrice: json['salesPrice']! as int,
          taxStatus: json['taxStatus']! as String,
          category: json['category']! as String,
          description: json['description']! as String,
          sku: json['sku']! as String,
          otherDetails: json['otherDetails']! as String,
          mainCategory: json['mainCategory']! as String,
          brand: json['brand'] as String,
          subCategory: json['subCategory']! as String,
          unit: json['unit']! as String,
          scheduleDate: json['scheduleDate']! as DateTime,
          manageInventory: json['manageInventory']! as bool,
          soh: json['soh']! as int,
          reorderLevel: json['reorderLevel']! as int,
          chargeShipping: json['chargeShipping']! as bool,
          shippingCharge: json['shippingCharge']! as int,
          sizeList: json['sizeList']! as List,
          imageUrls: json['imageUrls']! as List,
          seller: json['seller']! as Map<String, dynamic>,
          taxPercentage: json['taxPercentage']! as double,
        );

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
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
      'sizeList': sizeList,
      'imageUrls': imageUrls,
      'seller': seller,
      'taxPercentage': taxPercentage,
    };
  }
}
