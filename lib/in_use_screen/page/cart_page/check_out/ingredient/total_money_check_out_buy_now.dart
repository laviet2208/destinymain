import 'package:destinymain/data/finalLanguage.dart';
import 'package:flutter/material.dart';
import '../../../../../data/cartData/CartData.dart';
import '../../../../../data/finalData.dart';
import '../../../../../data/orderData/Order.dart';
import '../../../../../data/otherData/Tool.dart';
import '../../../../../general_ingredient/utils/utils.dart';
import '../../../../main_screen/main_screen.dart';
import '../../ingredient/cost_text_line.dart';
import '../check_out_controller.dart';
import 'receiver_info.dart';

class total_money_check_out_buy_now extends StatefulWidget {
  final Order order;
  final List<Cartdata> cartList;
  const total_money_check_out_buy_now({super.key, required this.order, required this.cartList});

  @override
  State<total_money_check_out_buy_now> createState() => _total_money_check_out_buy_nowState();
}

class _total_money_check_out_buy_nowState extends State<total_money_check_out_buy_now> {
  bool loading = false;

  double calculatetotalMoney() {
    double cost = 0;
    for (Cartdata cartdata in widget.cartList) {
      cost = cost + cartdata.dimension.cost * cartdata.number;
    }
    return cost;
  }

  bool _canPush() {
    if (widget.order.receiver.name != '' && widget.order.receiver.district != '' && widget.order.receiver.phoneNumber != '') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),

            cost_text_line(title: finalLanguage.mainLang.item + widget.order.productList.length.toString() + ')', content: getStringNumber(calculatetotalMoney()) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.grey,),

            SizedBox(height: 10,),

            GestureDetector(
              child: cost_text_line(title: finalLanguage.mainLang.voucher, content: (widget.order.voucher.id == '' ? finalLanguage.mainLang.doNotSelectVoucher : ('- ' + getStringNumber(getVoucherSale(widget.order.voucher, calculatetotalMoney())) + ' .USDT')), size: width/25, contentColor: Colors.blue, titleColor: Colors.grey,),
              onTap: () {

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

            cost_text_line(title: finalLanguage.mainLang.subTotal, content: getStringNumber(calculatetotalMoney() - getVoucherSale(widget.order.voucher, calculatetotalMoney())) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.black,),

            SizedBox(height: 20,),

            Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),

            receiver_info(order: widget.order),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 0, 76, 255)),
                  ),
                  onPressed: () async {
                    if ((calculatetotalMoney() - getVoucherSale(widget.order.voucher, calculatetotalMoney())) <= finalData.account.money) {
                      if (_canPush()) {
                        String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                        widget.order.id = 'DH' + id;
                        widget.order.status = 'A';
                        widget.order.createTime = getCurrentTime();
                        widget.order.owner = finalData.account.id;
                        setState(() {
                          loading = true;
                        });
                        await check_out_controller.push_new_order_buy_now(
                          widget.order,
                              () {setState(() {loading = false;}); Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => main_screen()),);},
                              () {setState(() {loading = false;});}, (calculatetotalMoney() - getVoucherSale(widget.order.voucher, calculatetotalMoney()))
                        );
                      } else {
                        toastMessage('Please fill receiver infomation');
                      }
                    } else {
                      toastMessage('OOP! you are not enough money');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: !loading ? Text(
                      finalLanguage.mainLang.confirmAndPay,
                      style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.white,
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                      ),
                    ) : CircularProgressIndicator(color: Colors.white,),
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
