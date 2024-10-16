import 'package:firebase_database/firebase_database.dart';

import '../../../../data/AdsData/AdsData.dart';
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
}