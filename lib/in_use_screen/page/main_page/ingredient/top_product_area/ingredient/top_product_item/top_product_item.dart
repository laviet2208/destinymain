import 'dart:convert';
import 'dart:typed_data';

import 'package:destinymain/data/product/Product.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/topProductController.dart';
import 'package:destinymain/in_use_screen/product_view_screen/product_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class top_product_item extends StatefulWidget {
  final Product product;
  const top_product_item({super.key, required this.product});

  @override
  State<top_product_item> createState() => _top_product_itemState();
}

class _top_product_itemState extends State<top_product_item> {
  late Uint8List image;
  bool loading = false;
  @override
  void initState() {
    image = Uint8List.fromList(base64Decode(widget.product.imageList.first));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: (width - 90)/5,
        height: (width - 90)/5,
        alignment: Alignment.center,
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
        child: !loading ? Padding(
          padding: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.memory(image),
          ),
        ) : SpinKitFoldingCube(color: Colors.black, size: 15,),
      ),
      onTap: () async {
        setState(() {
          loading = true;
        });
        Product productS = await topProductController.getProductById(widget.product.id);
        setState(() {
          loading = false;
        });
        generalController.changeScreenFade(context, product_view_screen(product: productS, previousWidget: main_screen(), type: 1,));
      },
    );
  }
}
