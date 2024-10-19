import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class top_product_item_loading extends StatelessWidget {
  const top_product_item_loading({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // return Container(
    //   width: (width - 90)/5,
    //   height: (width - 90)/5,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(1000),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.2),
    //         blurRadius: 10.0,
    //         offset: Offset(0, 2),
    //       ),
    //     ],
    //   ),
    // );
    return Shimmer.fromColors(
      baseColor: Colors.black,
      highlightColor: Colors.white,
      enabled: true,
      child: Container(
        width: (width - 90)/5,
        height: (width - 90)/5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color: Colors.black.withOpacity(0.04),
        ),
      ),
    );
  }
}
