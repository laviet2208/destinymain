import 'package:firebase_database/firebase_database.dart';

import '../../../../data/product/Product.dart';

class ProductInteract {
  ///type == 1: productList
  ///type == 2: UI
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

  static Future<String> getProductName(String id, int type) async {
    final reference = FirebaseDatabase.instance.ref();
    if (type == 1) {
      DatabaseEvent snapshot = await reference.child('productList').child(id).child('name').once();
      final dynamic data = snapshot.snapshot.value;
      return data.toString();
    }
    DatabaseEvent snapshot = await reference.child('UI').child('productTop').child(id).child('name').once();
    final dynamic data = snapshot.snapshot.value;
    return data.toString();
  }

  static Future<String> getFirstImage(String id, int type) async {
    final reference = FirebaseDatabase.instance.ref();
    if (type == 1) {
      DatabaseEvent snapshot = await reference.child('productList').child(id).child('imageList').child('0').once();
      final dynamic data = snapshot.snapshot.value;
      return data.toString();
    }
    DatabaseEvent snapshot = await reference.child('UI').child('productTop').child(id).child('imageList').child('0').once();
    final dynamic data = snapshot.snapshot.value;
    return data.toString();
  }
}