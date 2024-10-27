import 'package:auto_size_text/auto_size_text.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:flutter/material.dart';

import '../../../../data/finalData.dart';

class notice_page_appbar extends StatelessWidget {
  const notice_page_appbar({super.key});

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
            finalLanguage.mainLang.yourNotice,
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
