import 'package:destinymain/data/product/ProductDirectory.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/view_all_screen/view_all_product_indirectory/view_all_product_indirectory.dart';
import 'package:flutter/material.dart';

class product_directory_title extends StatelessWidget {
  final ProductDirectory productDirectory;
  const product_directory_title({super.key, required this.productDirectory});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        children: [
          Container(
            width: (width - 30)/3 * 2,
            child: Text(
              productDirectory.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: width/18,
                fontFamily: 'raleb',
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
              generalController.changeScreenFade(context, view_all_product_indirectory(productDirectory: productDirectory));
            },
          ),
        ],
      ),
    );
  }
}
