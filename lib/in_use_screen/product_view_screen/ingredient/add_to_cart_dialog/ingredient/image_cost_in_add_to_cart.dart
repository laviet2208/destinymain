import 'dart:typed_data';

import 'package:destinymain/data/product/Dimension.dart';
import 'package:flutter/material.dart';

import '../../../../../data/otherData/Tool.dart';

class image_cost_in_add_to_cart extends StatelessWidget {
  final Uint8List image;
  final Dimension selectDimension;
  const image_cost_in_add_to_cart({super.key, required this.image, required this.selectDimension});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      child: Row(
        children: [
          SizedBox(width: 10,),

          Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: MemoryImage(image),
              ),
            ),
          ),

          SizedBox(width: 10,),

          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: ListView(
                children: [
                  SizedBox(height: 10,),

                  Text(
                    getStringNumber(selectDimension.cost) + '.USDT',
                    style: TextStyle(
                      fontSize: width/20,
                      fontFamily: 'raleb',
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  Text(
                    getStringNumber(selectDimension.costBfSale) + '.USDT',
                    style: TextStyle(
                      fontSize: width/25,
                      fontFamily: 'rale',
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                  Text(
                    'Warehouse: ' + selectDimension.inventory.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: width/30,
                      fontFamily: 'rale',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 10,),
        ],
      ),
    );
  }
}
