import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../data/otherData/Tool.dart';
import '../../../../data/product/Product.dart';

class item_product_search extends StatelessWidget {
  final Product product;
  const item_product_search({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Uint8List image = Uint8List.fromList(base64Decode(product.imageList.first));
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(width: 10,),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Đặt bán kính bo tròn
                  child: Container(
                    width: (width - 40)/3,
                    height: (width - 40)/3,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.2),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(product.imageList.first),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 20,),

                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.name,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                            getCostString(product.dimensionList) + ' .USDT',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'rale',
                              fontSize: width/25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: getCostBeforeSaleString(product.dimensionList) + ' USDT',
                                  style: TextStyle(
                                    fontSize: width / 30,
                                    fontFamily: 'rale',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough, // Thêm gạch chéo
                                    decorationColor: Colors.grey, // Màu gạch chéo
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
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

          SizedBox(height: 10,),
        ],
      ),
    );
  }
}