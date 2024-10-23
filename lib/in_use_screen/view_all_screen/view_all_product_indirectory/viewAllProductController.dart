import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../data/product/Product.dart';

class viewAllProductController {
  static Future<List<Product>> get_product_list_by_type_id(String id, VoidCallback event) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").orderByChild('productType').equalTo(id).once();
    print('Gọi hàm lấy type thành công');
    final dynamic data = snapshot.snapshot.value;
    List<Product> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        Product product = Product.fromJson(value);
        if (product.showStatus != 0) {
          dataList.add(product);
          event();
        }
      });
    }
    return dataList;
  }

  static Future<List<Product>> get_product_list_by_direct_id(String id, VoidCallback event) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").orderByChild('productDirectory').equalTo(id).once();
    print('Gọi hàm lấy type thành công');
    final dynamic data = snapshot.snapshot.value;
    List<Product> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        Product product = Product.fromJson(value);
        if (product.showStatus != 0) {
          dataList.add(product);
          event();
        }
      });
    }
    return dataList;
  }
}