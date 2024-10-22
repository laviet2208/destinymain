import 'package:destinymain/data/finalData.dart';
import 'package:flutter/material.dart';
import '../../../data/otherData/Tool.dart';
import '../../../data/voucherData/Voucher.dart';
import 'ingredient/caculate_total_money.dart';
import 'ingredient/cart_page_appbar.dart';
import 'ingredient/item_cart.dart';
import 'ingredient/no_product_container.dart';

class cart_page extends StatefulWidget {
  const cart_page({super.key});

  @override
  State<cart_page> createState() => _cart_pageState();
}

class _cart_pageState extends State<cart_page> {
  final Voucher voucher = Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', type: 0, perCustom: 0, CustomList: [], maxSale: 0);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -width/3 - 70,
              right: -width/2.5,
              child: Container(
                width: width,
                height: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/image/decor/bubbles3.png'),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: cart_page_appbar(),
                  ),
                  backgroundColor: Colors.transparent,
                  body: Container(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(height: 10,),

                        finalData.cartList.isEmpty ? no_product_container() : Container(
                          child: ListView.builder(
                            itemCount: finalData.cartList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return item_cart(cartdata: finalData.cartList[index], event: () {setState(() {});},);
                            },
                          ),
                        ),

                        SizedBox(height: 20,),

                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: caculate_total_money(voucher: voucher,),
                        ),

                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
