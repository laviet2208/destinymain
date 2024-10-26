import 'package:firebase_database/firebase_database.dart';

class FlashSaleController {
  static Future<List<String>> get_top_product_ui() async {
    final reference = FirebaseDatabase.instance.ref();
    List<String> productList = [];
    DatabaseEvent snapshot = await reference.child('Flashsale').child('product').once();
    final dynamic data = snapshot.snapshot.value;
    for (final result in data) {
      productList.add(result.toString());
    }
    return productList;
  }
}