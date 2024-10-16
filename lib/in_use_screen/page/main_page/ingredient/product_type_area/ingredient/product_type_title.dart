import 'package:flutter/material.dart';

class product_type_title extends StatelessWidget {
  const product_type_title({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 40,
      child: Row(
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: width/18,
              fontFamily: 'raleb',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(child: Container()),

          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: width/23,
                        fontFamily: 'rale',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 10,),

                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: Color.fromARGB(255, 0, 76, 255),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
