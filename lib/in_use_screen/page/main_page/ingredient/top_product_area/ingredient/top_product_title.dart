import 'package:flutter/material.dart';

class top_product_title extends StatelessWidget {
  const top_product_title({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 40,
      child: Row(
        children: [
          Text(
            'Top Products',
            style: TextStyle(
              fontSize: width/18,
              fontFamily: 'raleb',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(child: Container()),
        ],
      ),
    );
  }
}
