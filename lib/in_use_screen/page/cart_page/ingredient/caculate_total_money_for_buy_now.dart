import 'package:destinymain/data/cartData/CartData.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/in_use_screen/page/cart_page/check_out/check_out_buy_now_screen.dart';
import 'package:flutter/material.dart';
import '../../../../data/finalData.dart';
import '../../../../data/orderData/Order.dart';
import '../../../../data/orderData/Receiver.dart';
import '../../../../data/otherData/Tool.dart';
import '../../../../data/voucherData/Voucher.dart';
import '../../../../general_ingredient/utils/utils.dart';
import '../../voucher_page/ingredient/voucher_select/voucher_select.dart';
import '../check_out/check_out_screen.dart';
import 'cost_text_line.dart';

class caculate_total_money_for_buy_now extends StatefulWidget {
  final Voucher voucher;
  final List<Cartdata> cartList;
  const caculate_total_money_for_buy_now({super.key, required this.voucher, required this.cartList});

  @override
  State<caculate_total_money_for_buy_now> createState() => _caculate_total_money_for_buy_nowState();
}

class _caculate_total_money_for_buy_nowState extends State<caculate_total_money_for_buy_now> {
  double calculatetotalMoney() {
    double cost = 0;
    for (Cartdata cartdata in widget.cartList) {
      cost = cost + cartdata.dimension.cost * cartdata.number;
    }
    return cost;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),

            cost_text_line(title: finalLanguage.mainLang.item + widget.cartList.length.toString() + ')', content: getStringNumber(calculatetotalMoney()) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.grey,),

            SizedBox(height: 10,),

            GestureDetector(
              child: cost_text_line(title: finalLanguage.mainLang.voucher, content: (widget.voucher.id == '' ? 'Select voucher' : ('- ' + getStringNumber(getVoucherSale(widget.voucher, calculatetotalMoney())) + ' .USDT')), size: width/25, contentColor: Colors.blue, titleColor: Colors.grey,),
              onTap: () {
                if (widget.cartList.length == 0) {
                  toastMessage('Your cart is emty');
                } else {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    barrierColor: Colors.white,
                    builder: (context) {
                      return voucher_select(voucher: widget.voucher, ontap: () {
                        setState(() {

                        });
                      }, cost: calculatetotalMoney());
                    },
                  );
                }
              },
            ),

            SizedBox(height: 10,),

            Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 10,),

            cost_text_line(title: finalLanguage.mainLang.subTotal, content: getStringNumber(calculatetotalMoney() - getVoucherSale(widget.voucher, calculatetotalMoney())) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.black,),

            SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 0, 76, 255)),
                  ),
                  onPressed: () {
                    if (widget.cartList.isNotEmpty) {
                      Order order = Order(id: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', type: 0, perCustom: 0, CustomList: [], maxSale: 0), note: '', productList: [], receiver: Receiver(name: '', nation: '', phoneNumber: '', city: '', district: '', podcode: '', province: '', address: ''), createTime: getCurrentTime(), status: '', owner: '');
                      order.productList = widget.cartList;
                      order.voucher = widget.voucher;
                      order.receiver.name = finalData.account.firstName + ' ' + finalData.account.lastName;
                      order.receiver.phoneNumber = finalData.account.phoneNum;
                      order.receiver.district = finalData.account.address;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => check_out_buy_now_screen(order: order, beforewidget: main_screen(), cartList: widget.cartList,)),);
                    } else {
                      toastMessage('Your cart is empty');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      'Check out',
                      style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.white,
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
