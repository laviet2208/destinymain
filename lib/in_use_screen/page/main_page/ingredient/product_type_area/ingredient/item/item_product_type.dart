import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:destinymain/data/product/ProductType.dart';
import 'package:flutter/material.dart';

class item_product_type extends StatefulWidget {
  final ProductType productType;
  const item_product_type({super.key, required this.productType});

  @override
  State<item_product_type> createState() => _item_product_typeState();
}

class _item_product_typeState extends State<item_product_type> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 45)/2;
    double height = width/(165/192);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            left: 5,
            right: 5,
            child: Container(
              height: width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // color: Colors.grey.withOpacity(0.1),
              ),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(Uint8List.fromList(base64Decode(widget.productType.image)), fit: BoxFit.cover,),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            left: 5,
            child: Container(
              width: width/3*2 - 10,
              height: height - (width - 10) - 3 - 10,
              decoration: BoxDecoration(

              ),
              child: Text(
                widget.productType.name.length > 9 ? widget.productType.name.substring(0, 9) : widget.productType.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: width/9,
                  fontFamily: 'raleb',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              width: width - 10 - (width/3*2 - 10) - 20,
              height: height - (width - 10) - 3 - 10,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 223, 233, 255),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                (Random().nextInt(151) + 50).toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: width/12,
                  fontFamily: 'raleb',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
