import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../data/finaldata.dart';
import '../../../main_screen/main_screen.dart';

class account_info_app_bar extends StatelessWidget {
  const account_info_app_bar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 55,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Container(
                    width: 30,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

                Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 7),
                  child: Container(
                    width: (width - 40)/2,
                    child: Text(
                      "Your profile",
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: 'raleb',
                        color: Colors.black,
                        fontSize: width/15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
