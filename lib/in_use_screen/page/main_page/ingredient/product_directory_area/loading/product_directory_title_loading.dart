import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class product_directory_title_loading extends StatelessWidget {
  const product_directory_title_loading({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              width: (width - 30)/3 * 2,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Colors.black.withOpacity(0.04),
              ),
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
    );  }
}
