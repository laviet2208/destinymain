import 'dart:convert';
import 'dart:typed_data';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:flutter/material.dart';
import '../../../../data/cartData/CartData.dart';
import '../../../../data/otherData/Tool.dart';
import '../../../../data/finalData.dart';
import 'change_number.dart';

class item_cart_buy_now extends StatefulWidget {
  final Cartdata cartdata;
  final VoidCallback event;
  const item_cart_buy_now({super.key, required this.cartdata, required this.event});

  @override
  State<item_cart_buy_now> createState() => _item_cart_buy_nowState();
}

class _item_cart_buy_nowState extends State<item_cart_buy_now> {
  // late Uint8List image;

  @override
  void initState() {
    // image = Uint8List.fromList(base64Decode(widget.cartdata.dimension.image));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(width: 10,),

                Container(
                  width: (width - 30)/3,
                  height: (width - 30)/3,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(widget.cartdata.dimension.image),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.cartdata.product.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: width/25,
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          height: 30,
                          child: Row(
                            children: [
                              Text(
                                finalLanguage.mainLang.number,
                                style: TextStyle(
                                  fontFamily: 'muli',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),

                              SizedBox(width: 10,),

                              Container(
                                width: width/6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.cartdata.number.toString(),
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getStringNumber(widget.cartdata.dimension.cost) + ' .USDT',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: width/20,
                            ),
                          ),
                        ),

                        SizedBox(height: 4,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getStringNumber(widget.cartdata.dimension.costBfSale) + ' .USDT',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.normal,
                              fontSize: width/25,
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
