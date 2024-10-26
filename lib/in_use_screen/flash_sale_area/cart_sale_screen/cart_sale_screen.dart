import 'package:destinymain/in_use_screen/flash_sale_area/cart_sale_screen/ingredient/cart_sale_appbar.dart';
import 'package:flutter/material.dart';
import '../../../data/finalData.dart';
import '../../../data/otherData/Tool.dart';
import '../../../data/voucherData/Voucher.dart';
import 'ingredient/caculate_total_money.dart';
import '../../page/cart_page/ingredient/no_product_container.dart';
import 'ingredient/item_cart.dart';

class cart_sale_screen extends StatefulWidget {
  const cart_sale_screen({super.key});

  @override
  State<cart_sale_screen> createState() => _cart_sale_screenState();
}

class _cart_sale_screenState extends State<cart_sale_screen> {
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
                    title: cart_sale_appbar(),
                  ),
                  backgroundColor: Colors.transparent,
                  body: Container(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(height: 10,),

                        finalData.cartListSale.isEmpty ? no_product_container() : Container(
                          child: ListView.builder(
                            itemCount: finalData.cartListSale.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return item_cart(cartdata: finalData.cartListSale[index], event: () {setState(() {});},);
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
