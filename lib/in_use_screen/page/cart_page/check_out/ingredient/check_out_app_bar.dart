import 'package:auto_size_text/auto_size_text.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class check_out_app_bar extends StatelessWidget {
  const check_out_app_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            width: 40,
            height: 40,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => main_screen()),
            );
          },
        ),

        SizedBox(width: 30,),

        Expanded(
          child: Container(
            height: 24,
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              'Check out',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'raleb',
                color: Colors.black,
                fontSize: 100,
              ),
            ),
          ),
        ),

        SizedBox(width: 20,),
      ],
    );
  }
}
