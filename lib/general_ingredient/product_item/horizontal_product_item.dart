import 'dart:convert';
import 'dart:typed_data';
import 'package:destinymain/data/otherData/Tool.dart';
import 'package:destinymain/data/product/Product.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/product_view_screen/product_view_screen.dart';
import 'package:flutter/material.dart';

import '../../in_use_screen/product_view_screen/ingredient/add_to_cart_dialog/add_to_cart_dialog.dart';

class horizontal_product_item extends StatelessWidget {
  final Product product;
  final Widget current;
  final int type;
  const horizontal_product_item({super.key, required this.product, required this.current, required this.type});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width1 = (width - 45)/2;
    // Uint8List image = Uint8List.fromList(base64Decode(product.imageList.first));
    return Container(
      width: width1,
      height: height/2*3,
      child: Stack(
        children: <Widget> [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 8,
                      right: 8,
                      child: Container(
                        width: width1 - 16,
                        height: width1 - 16,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(product.imageList.first)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 7,
                      left: 8,
                      right: 8,
                      top: width1 - 7,
                      child: Container(
                        width: width1 - 14,
                        height: width1 - 14,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: 'rale',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/30,
                                ),
                              ),
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                getCostString(product.dimensionList),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: 'raleb',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: width/22,
                                ),
                              ),
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                getCostBeforeSaleString(product.dimensionList),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: 'rale',
                                  // color: Colors.black,
                                  color: Color.fromARGB(255, 199, 199, 199),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: width/30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                generalController.changeScreenSlide(context, product_view_screen(product: product, previousWidget: current, type: type,));
              },
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              child: Container(
                width: width1/5.5,
                height: width1/5.5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 76, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                  ),
                  builder: (context) {
                    return add_to_cart_dialog(product: product, type: type,);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
