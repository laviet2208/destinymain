import 'dart:convert';
import 'dart:typed_data';

import 'package:destinymain/data/finalLanguage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../../../data/cartData/CartData.dart';
import '../../../../../data/otherData/Tool.dart';

class item_product_in_checkout extends StatefulWidget {
  final Cartdata cartdata;
  const item_product_in_checkout({super.key, required this.cartdata});

  @override
  State<item_product_in_checkout> createState() => _item_product_in_checkoutState();
}

class _item_product_in_checkoutState extends State<item_product_in_checkout> {
  late Uint8List image;

  @override
  void initState() {
    image = Uint8List.fromList(base64Decode(widget.cartdata.dimension.image));
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
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(image, fit: BoxFit.fitHeight,),
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
                            widget.cartdata.dimension.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'sf',
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
                                  fontFamily: 'sf',
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
                                      fontFamily: 'sf',
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
                              fontFamily: 'raleb',
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
                              fontFamily: 'rale',
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
