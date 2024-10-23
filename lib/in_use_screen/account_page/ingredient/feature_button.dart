import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class feature_button extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback event;
  const feature_button({super.key, required this.iconData, required this.title, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 22,
                color: Colors.black,
              ),

              SizedBox(width: 15,),

              Expanded(
                child: Container(
                  height: 23,
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    title,
                    style: TextStyle(
                      fontFamily: 'rale',
                      fontWeight: FontWeight.normal,
                      fontSize: 100,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Icon(
                Icons.keyboard_arrow_right,
                size: 25,
                color: Colors.black,
              ),
            ],
          ),
        ),
        onTap: event,
      ),
    );
  }
}
