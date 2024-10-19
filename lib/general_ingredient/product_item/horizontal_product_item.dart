import 'dart:convert';
import 'dart:typed_data';
import 'package:destinymain/data/otherData/Tool.dart';
import 'package:destinymain/data/product/Product.dart';
import 'package:flutter/material.dart';

class horizontal_product_item extends StatelessWidget {
  final Product product;
  const horizontal_product_item({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width1 = (width - 45)/2;
    return GestureDetector(
      child: Container(
        width: width1,
        height: height/2*3,
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
          children: <Widget> [
            Positioned(
              top: 8,
              left: 8,
              right: 8,
              // child: Container(
              //   width: width1 - 16,
              //   height: width1 - 16,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(5),
              //     child: Image.memory(Uint8List.fromList(base64Decode(product.imageList.first))),
              //   ),
              // ),
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
                        child: Image.memory(Uint8List.fromList(base64Decode(product.imageList.first))),
                      ),
                    ),

                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        width: (width1 - 16)/5,
                        height: (width1 - 16)/5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.favorite_border,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

                },
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
    );
  }
}
