import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:flutter/material.dart';

class cart_page_appbar extends StatelessWidget {
  const cart_page_appbar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      height: 50,
      child: Row(
        children: [
          Text(
            finalLanguage.mainLang.yourCart1 + finalData.cartList.length.toString() + ')',
            style: TextStyle(
              fontFamily: 'raleb',
              color: Colors.black,
              fontSize: width/17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
