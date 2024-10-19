import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_directory_area/loading/product_directory_title_loading.dart';
import 'package:flutter/material.dart';

class product_directory_area_loading extends StatelessWidget {
  const product_directory_area_loading({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15,),
            child: product_directory_title_loading(),
          ),

          Container(
            height: ((width - 45)/2)/2*3 + 20,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Container(),
                );
              },
            ),
          ),

          SizedBox(height: 8,),
        ],
      ),
    );
  }
}
