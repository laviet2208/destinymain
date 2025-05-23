import 'package:destinymain/in_use_screen/flash_sale_area/flash_sale_screen/flash_sale_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../data/finalData.dart';
import '../../../../../data/orderData/Order.dart';
import '../../../../../data/otherData/Tool.dart'; 
import '../../../../../general_ingredient/utils/utils.dart';
import '../../../page/cart_page/ingredient/cost_text_line.dart';
import '../check_out_controller.dart';
import 'receiver_info.dart';

class total_money_check_out extends StatefulWidget {
  final Order order;
  const total_money_check_out({super.key, required this.order});

  @override
  State<total_money_check_out> createState() => _total_money_check_outState();
}

class _total_money_check_outState extends State<total_money_check_out> {
  bool loading = false;

  bool _canPush() {
    if (widget.order.receiver.name != '' && widget.order.receiver.district != '' &&
         widget.order.receiver.nation != '' && widget.order.receiver.podcode != '' && widget.order.receiver.phoneNumber != '') {
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

            cost_text_line(title: 'Items (' + widget.order.productList.length.toString() + ')', content: getStringNumber(calculatetotalSaleMoney()) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.grey,),

            SizedBox(height: 10,),

            GestureDetector(
              child: cost_text_line(title: 'Voucher', content: (widget.order.voucher.id == '' ? 'do not select' : ('- ' + getStringNumber(getVoucherSale(widget.order.voucher, calculatetotalSaleMoney())) + ' .USDT')), size: width/25, contentColor: Colors.blue, titleColor: Colors.grey,),
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

            cost_text_line(title: 'Sub total', content: getStringNumber(calculatetotalSaleMoney() - getVoucherSale(widget.order.voucher, calculatetotalSaleMoney())) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.black,),

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
                    if ((calculatetotalSaleMoney() - getVoucherSale(widget.order.voucher, calculatetotalSaleMoney())) <= finalData.account.money) {
                      if (_canPush()) {
                        String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                        widget.order.id = 'DH' + id;
                        widget.order.status = 'A';
                        widget.order.createTime = getCurrentTime();
                        widget.order.owner = finalData.account.id;
                        setState(() {
                          loading = true;
                        });
                        await check_out_controller.push_new_order(
                          widget.order,
                              () {setState(() {loading = false;}); Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => flash_sale_screen()),);},
                              () {setState(() {loading = false;});},
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
                      'Confirm and pay',
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
