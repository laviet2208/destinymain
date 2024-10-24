import 'package:destinymain/in_use_screen/page/main_page/final_data/mainpage_final_data.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/ingredient/top_product_item/top_product_item.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/ingredient/top_product_item/top_product_item_loading.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/ingredient/top_product_title.dart';
import 'package:flutter/material.dart';

import '../../../../../data/product/Product.dart';
import '../../../../../general_ingredient/generalController.dart';
import '../../../../main_screen/main_screen.dart';
import '../../../../product_view_screen/product_view_screen.dart';
import 'topProductController.dart';

class top_product_area extends StatelessWidget {
  const top_product_area({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15,),
            child: top_product_title(),
          ),

          SizedBox(height: 4,),

          Container(
            height: (width - 90)/5,
            child: mainpage_final_data.topProduct.isNotEmpty ? ListView.builder(
              itemCount: mainpage_final_data.topProduct.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 15, right: 15),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: top_product_item(product: mainpage_final_data.topProduct[index],),
                );
              },
            ) : ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 15, right: 15),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: top_product_item_loading(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
