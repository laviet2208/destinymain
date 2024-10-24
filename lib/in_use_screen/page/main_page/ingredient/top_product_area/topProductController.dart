import 'package:destinymain/data/otherData/Tool.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../../data/product/Product.dart';

class topProductController {
  static Future<Product> getProductById(String id) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").child(id).once();
    final dynamic data = snapshot.snapshot.value;
    if (data != null) {
      Product product = Product.fromJson(data);
      return product;
    }
    return Product(id: '', name: '', productType: '', showStatus: 0, createTime: getCurrentTime(), description: '', productDirectory: '', dimensionList: [], imageList: []);
  }
}