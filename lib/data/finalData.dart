import 'package:destinymain/data/Account/Account.dart';
import 'package:destinymain/data/product/Product.dart';
import 'cartData/CartData.dart';
import 'otherData/Time.dart';

class finalData {
  static int currentPage = 0;
  static bool isComplete = false;
  static List<Cartdata> cartList = [];
  static List<Cartdata> cartListSale = [];
  static List<Product> allProductList = [];
  static Account account = Account(id: '', username: '', password: '', address: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 4, month: 8, year: 2024), money: 200, firstName: '', lastName: '', phoneNum: '', lockstatus: 1, voucherList: []);
}