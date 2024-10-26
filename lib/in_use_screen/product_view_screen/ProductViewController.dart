import 'package:destinymain/data/otherData/Tool.dart';
import 'package:destinymain/data/product/Dimension.dart';

import '../../data/cartData/CartData.dart';
import '../../data/finalData.dart';
import '../../data/product/Product.dart';
import '../../general_ingredient/utils/utils.dart';

class ProductViewController {
  static void add_to_cart_handle(Product product, Dimension dimension, int number, int type) {
    Product product1 = Product(id: product.id, name: product.name, productType: '', showStatus: 1, createTime: getCurrentTime(), description: '', productDirectory: '', dimensionList: [], imageList: []);
    if (number > 0) {
      if (number <= dimension.inventory) {
        if (product1.id != '') {
          bool check = true;
          for (Cartdata cartdata in (type == 1 ? finalData.cartList : finalData.cartListSale)) {
            if (cartdata.product.id == product1.id && cartdata.dimension.name == dimension.name) {
              cartdata.number = cartdata.number + number;
              check = false;
              break;
            }
          }
          if (check) {
            product1.imageList = [];
            product1.dimensionList = [];
            product1.description = '';
            product1.productDirectory = '';
            product1.productType = '';
            type == 1 ? (finalData.cartList.add(Cartdata(product: product1, number: number, dimension: dimension))) : (finalData.cartListSale.add(Cartdata(product: product1, number: number, dimension: dimension)));
          }
          print('aaa:  ' + (type == 1 ? finalData.cartList.length.toString() : finalData.cartListSale.length.toString()));
          toastMessage('Add success');
        } else {
          toastMessage('Product error');
        }
      } else {
        toastMessage('Number must smaller than inventory');
      }
    } else {
      toastMessage('Number must bigger than 0');
    }
  }
}