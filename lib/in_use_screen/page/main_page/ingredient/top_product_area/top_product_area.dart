import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/ingredient/top_product_title.dart';
import 'package:flutter/material.dart';

class top_product_area extends StatelessWidget {
  const top_product_area({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          top_product_title(),

          SizedBox(height: 8,),


        ],
      ),
    );
  }
}
