import 'dart:convert';

import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/data/product/Product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDataHandle {
  ///Key List
  ///enterTime: first time enter
  /// This class will be handle interact between product data with firebase and share preference
  /// WriteStringData
  static Future<void> WriteStringData(String key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  /// WriteStringDataList
  static Future<void> WriteStringDataList(String key, List<String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, data);
  }

  /// GetStringData
  static Future<String> GetStringData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data != null ? data : '';
  }

  /// WriteIntData
  static Future<void> WriteIntData(String key, int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, data);
  }

  /// GetStringData
  static Future<int> GetIntData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? data = prefs.getInt(key);
    return data != null ? data : -1;
  }

  /// CheckIfFirstTimeEnter
  static Future<bool> CheckIfFirstTimeEnter() async {
    int firstTime = await GetIntData('enterTime');
    return firstTime == -1 ? true : false;
  }

  /// getAllProductFB: get all product from firebase realtime database
  static Future<void> getAllProductFB() async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").orderByChild('showStatus').equalTo(1).once();
    final dynamic data = snapshot.snapshot.value;
    if (data != null) {
      finalData.allProductList.clear();
      data.forEach((key, value) {
        finalData.allProductList.add(Product.fromJson(value));
      });
      finalData.isComplete = true;
      // await WriteStringDataList('productList', dataList.map((product) => jsonEncode(product.toJsonString())).toList());
      print('Đã lưu xong data');
    }

  }
}