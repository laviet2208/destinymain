import 'package:destinymain/in_use_screen/flash_sale_area/flash_sale_screen/flash_sale_screen.dart';
import 'package:flutter/material.dart';

import '../../../../general_ingredient/generalController.dart';

class cart_sale_appbar extends StatelessWidget {
  const cart_sale_appbar({super.key});

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
                  child: GestureDetector(
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () {
                      generalController.changeScreenSlide(context, flash_sale_screen());
                    },
                  ),
                ),

                SizedBox(width: 10,),

                Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 7),
                  child: Container(
                    child: Text(
                      "Flash Sale Cart",
                      maxLines: 1,
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
    );  }
}
