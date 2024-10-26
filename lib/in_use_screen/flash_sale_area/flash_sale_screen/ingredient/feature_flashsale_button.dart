import 'package:flutter/material.dart';

class feature_flashsale_button extends StatelessWidget {
  final IconData iconData;
  final String text1;
  final String text2;
  final Color color1;
  final Color color2;
  final VoidCallback event;
  const feature_flashsale_button({super.key, required this.iconData, required this.text1, required this.text2, required this.color1, required this.color2, required this.event});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 10,),

            Icon(
              iconData,
              color: Colors.black,
              size: 18,
            ),

            SizedBox(width: 10,),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: text1,
                    style: TextStyle(
                      fontFamily: 'rale',
                      fontSize: width/30,
                      color: color1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: text2,
                    style: TextStyle(
                      fontFamily: 'rale',
                      fontSize: width/30,
                      color: color2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10,),
          ],
        ),
      ),
      onTap: event,
    );
  }
}
