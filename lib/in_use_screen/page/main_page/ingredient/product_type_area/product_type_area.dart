import 'package:destinymain/in_use_screen/page/main_page/final_data/mainpage_final_data.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_type_area/ingredient/item/item_product_type.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_type_area/ingredient/item/item_product_type_loading.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_type_area/ingredient/product_type_title.dart';
import 'package:flutter/material.dart';

class product_type_area extends StatelessWidget {
  const product_type_area({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15,),
            child: product_type_title(),
          ),

          SizedBox(height: 8,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15,),
            child: mainpage_final_data.typeList.isNotEmpty ? Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // số phần tử trên mỗi hàng
                  mainAxisSpacing: 8, // khoảng cách giữa các hàng
                  crossAxisSpacing: 15, // khoảng cách giữa các cột
                  childAspectRatio: 165/192,
                ),
                itemCount: mainpage_final_data.typeList.length > 4 ? 4 : mainpage_final_data.typeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: item_product_type(productType: mainpage_final_data.typeList[index]),
                  );
                },
              ),
            ) : Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // số phần tử trên mỗi hàng
                  mainAxisSpacing: 8, // khoảng cách giữa các hàng
                  crossAxisSpacing: 15, // khoảng cách giữa các cột
                  childAspectRatio: 165/192,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: item_product_type_loading(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
