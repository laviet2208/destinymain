import 'dart:ui';

import 'package:destinymain/data/product/Product.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../data/AdsData/AdsData.dart';
import '../../../../data/product/ProductDirectory.dart';
import '../../../../data/product/ProductType.dart';

class MainPageController {
  /// This class contain functions what elements in main page use for interact with realtime database
  ///
  /// getAdsData
  static Future<List<AdsData>> getAdsData() async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("adsData").orderByChild('status').equalTo(1).once();
    final dynamic data = snapshot.snapshot.value;
    List<AdsData> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        dataList.add(AdsData.fromJson(value));
      });
    }
    return dataList;
  }

  /// getProductType
  static Future<List<ProductType>> getProductType() async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productType").limitToFirst(4).once();
    final dynamic data = snapshot.snapshot.value;
    List<ProductType> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        dataList.add(ProductType.fromJson(value));
      });
    }
    return dataList;
  }

  /// getAllProductType
  static Future<List<ProductType>> getAllProductType() async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productType").once();
    final dynamic data = snapshot.snapshot.value;
    List<ProductType> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        dataList.add(ProductType.fromJson(value));
      });
    }
    return dataList;
  }

  /// getTopProduct
  static Future<List<Product>> getTopProduct() async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child('UI').child('productTop').once();
    final dynamic data = snapshot.snapshot.value;
    List<Product> dataList = [];
    if (data != null) {
      for (final result in data) {
        dataList.add(Product.fromJson(result));
      }
    }
    return dataList;
  }

  /// getDirectoryUi
  static Future<List<String>> getDirectoryUi() async {
    final reference = FirebaseDatabase.instance.ref();
    List<String> directoryList = [];
    DatabaseEvent snapshot = await reference.child('UI').child('productDirectory').once();
    final dynamic data = snapshot.snapshot.value;
    for (final result in data) {
      String id = result.toString();
      directoryList.add(id);
    }
    return directoryList;
  }

  /// getDirectory
  static Future<ProductDirectory> getDirectory(String id) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child('productDirectory').child(id).once();
    final dynamic data = snapshot.snapshot.value;
    return ProductDirectory.fromJson(data);
  }
}