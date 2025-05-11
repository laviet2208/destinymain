import 'package:destinymain/data/finalData.dart';
import 'package:flutter/material.dart';
import '../../../../data/finalLanguage.dart';
import '../../../../data/otherData/Tool.dart';
import '../../../../data/voucherData/Voucher.dart';
import 'gift_voucher/gift_voucher.dart';

class voucher_individual_item extends StatelessWidget {
  final Voucher voucher;
  final VoidCallback event;
  const voucher_individual_item({super.key, required this.voucher, required this.event});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 10;
    return Container(
      width: width,
      height: width/(2301/879),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 189, 21, 34),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 5,),

                  Padding(
                    padding: EdgeInsets.only(left: 22, right: 22),
                    child: Container(
                      height: width - ((width/(2301/879)) * (1599/879) - 20) - 44,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/decor/moon.png'),
                        )
                      ),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: getStringNumber(voucher.Money),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width / 15,
                                  fontFamily: 'muli',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                // text: voucher.maxSale != 0 ? '%' : '\nUSDT',
                                text: "\nVoucher",
                                style: TextStyle(
                                  color: Colors.white,
                                  // fontSize: voucher.maxSale != 0 ? width / 15 : width/24,
                                  fontSize: 10,
                                  fontFamily: 'muli',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 3,),

                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        finalLanguage.mainLang.giftThis,
                        style: TextStyle(
                          fontFamily: 'raleb',
                          color: Color.fromARGB(255, 1, 162, 156),
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return gift_voucher(voucher: voucher, event: event,);
                        },
                      );
                    },
                  ),

                  SizedBox(height: 3,),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 7, right: 7),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            getDayTimeString(voucher.startTime) + ' - ' + getDayTimeString(voucher.endTime),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'raleb',
                              fontWeight: FontWeight.bold,
                              fontSize: 7.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5,),
                ],
              ),
            ),
          ),

          Container(
            width: (width/(2301/879)) * (1599/879) - 20,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 1, 162, 156),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/image/decor/voucher.jpg')
              ),
            ),
          ),
        ],
      ),

    );
  }
}