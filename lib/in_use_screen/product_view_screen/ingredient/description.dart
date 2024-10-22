import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class description extends StatelessWidget {
  final String content;
  const description({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'About this item',
                style: TextStyle(
                  fontFamily: 'raleb',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width/17,
                ),
              ),
            ),

            SizedBox(height: 5,),

            Container(
              child: HtmlWidget(
                content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
