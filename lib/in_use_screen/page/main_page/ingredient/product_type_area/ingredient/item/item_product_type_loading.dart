import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class item_product_type_loading extends StatelessWidget {
  const item_product_type_loading({super.key});

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
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                height: width - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.black.withOpacity(0.04),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            left: 5,
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                width: width/3*2 - 10,
                height: height - (width - 10) - 3 - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.black.withOpacity(0.04),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            right: 5,
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                width: width - 10 - (width/3*2 - 10) - 20,
                height: height - (width - 10) - 3 - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.black.withOpacity(0.04),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
