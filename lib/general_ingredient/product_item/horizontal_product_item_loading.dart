import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class horizontal_product_item_loading extends StatelessWidget {
  const horizontal_product_item_loading({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width1 = (width - 45)/2;
    return Container(
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
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                width: width1 - 16,
                height: width1 - 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.04),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                width: width1/5.5,
                height: width1/5.5,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
