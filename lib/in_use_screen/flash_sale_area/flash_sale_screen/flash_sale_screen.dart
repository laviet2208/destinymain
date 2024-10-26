import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/data/product/Product.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/flash_sale_area/cart_sale_screen/cart_sale_screen.dart';
import 'package:destinymain/in_use_screen/flash_sale_area/controller.dart';
import 'package:destinymain/in_use_screen/flash_sale_area/flash_sale_screen/ingredient/feature_flashsale_button.dart';
import 'package:destinymain/in_use_screen/flash_sale_area/flash_sale_screen/ingredient/flash_sale_screen_appbar.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/topProductController.dart';
import 'package:destinymain/in_use_screen/product_view_screen/product_view_screen.dart';
import 'package:flutter/material.dart';
import '../../../general_ingredient/product_item/horizontal_product_item.dart';
import '../../../general_ingredient/product_item/horizontal_product_item_loading.dart';
import '../check_out/check_out_screen.dart';

class flash_sale_screen extends StatefulWidget {
  const flash_sale_screen({super.key});

  @override
  State<flash_sale_screen> createState() => _flash_sale_screenState();
}

class _flash_sale_screenState extends State<flash_sale_screen> {
  List<String> keyList = [];
  List<Product> productList = [];
  bool loading = false;

  Future<void> _refresh() async {
    keyList.clear();
    productList.clear();
    setState(() {
      loading = true;
    });
    if (finalData.isComplete) {
      keyList = await FlashSaleController.get_top_product_ui();
      for (int i = 0; i < keyList.length; i++) {
        List<Product> pros = finalData.allProductList.where((x) => x.id == keyList[i]).toList();
        if (pros.isNotEmpty) {
          productList.add(pros.first);
        }
      }
      setState(() {
        loading = false;
      });
    } else {
      keyList = await FlashSaleController.get_top_product_ui();
      for (int i = 0; i < keyList.length; i++) {
        Product product = await topProductController.getProductById(keyList[i]);
        productList.add(product);
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -width/3 - 20,
                right: -width/3,
                child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/image/decor/bubbles3.png'),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: flash_sale_screen_appbar(),
                  ),
                  body: !loading ? RefreshIndicator(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 15,),
                            child: productList.isNotEmpty ? Container(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // số phần tử trên mỗi hàng
                                  mainAxisSpacing: 8, // khoảng cách giữa các hàng
                                  crossAxisSpacing: 15, // khoảng cách giữa các cột
                                  childAspectRatio: ((width - 45)/2)/(((width - 45)/2)/2*3 + 20),
                                ),
                                itemCount: productList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: horizontal_product_item(product: productList[index], current: widget, type: 2,),
                                    onTap: () {
                                      generalController.changeScreenFade(context, product_view_screen(product: productList[index], previousWidget: widget, type: 2));
                                    },
                                  );
                                },
                              ),
                            ) : Container(
                              alignment: Alignment.center,
                              child: Text(
                                'There are no products here.',
                                style: TextStyle(
                                  fontSize: width/25,
                                  fontFamily: 'rale',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,)
                      ],
                    ),
                    onRefresh: _refresh,
                  ) : Container(
                    padding: EdgeInsets.only(left: 15, right: 15,),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // số phần tử trên mỗi hàng
                        mainAxisSpacing: 8, // khoảng cách giữa các hàng
                        crossAxisSpacing: 15, // khoảng cách giữa các cột
                        childAspectRatio: ((width - 45)/2)/(((width - 45)/2)/2*3 + 20),
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: horizontal_product_item_loading(),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 10,
                right: 5,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      feature_flashsale_button(iconData: Icons.add_shopping_cart, text1: 'Flash Sale ', text2: finalLanguage.mainLang.cart, color1: Colors.black, color2: Colors.blue,
                        event: () {
                          generalController.changeScreenSlide(context, cart_sale_screen());
                        },),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        generalController.changeScreenFade(context, main_screen());
        return true;
      },
    );
  }
}
