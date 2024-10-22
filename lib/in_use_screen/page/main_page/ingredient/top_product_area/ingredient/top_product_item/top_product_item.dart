import 'dart:convert';
import 'dart:typed_data';

import 'package:destinymain/data/product/Product.dart';
import 'package:flutter/material.dart';

import '../../../../final_data/mainpage_final_data.dart';

class top_product_item extends StatelessWidget {
  final Product product;
  const top_product_item({super.key, required this.product,});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Uint8List image = Uint8List.fromList(base64Decode(product.imageList.first));
    return Container(
      width: (width - 90)/5,
      height: (width - 90)/5,
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
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Image.memory(image),
        ),
      ),
    );
  }
}
