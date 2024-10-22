import 'package:destinymain/data/product/Dimension.dart';

import '../../data/cartData/CartData.dart';
import '../../data/finalData.dart';
import '../../data/product/Product.dart';
import '../../general_ingredient/utils/utils.dart';

class ProductViewController {
  static void add_to_cart_handle(Product product, Dimension dimension, int number) {
    if (number > 0) {
      if (number <= dimension.inventory) {
        if (product.id != '') {
          bool check = true;
          for (Cartdata cartdata in finalData.cartList) {
            if (cartdata.product.id == product.id && cartdata.dimension.name == dimension.name) {
              cartdata.number = cartdata.number + number;
              check = false;
              break;
            }
          }
          if (check) {
            product.imageList = [];
            product.dimensionList = [];
            product.description = '';
            product.productDirectory = '';
            product.productType = '';
            finalData.cartList.add(Cartdata(product: product, number: number, dimension: dimension));
          }
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