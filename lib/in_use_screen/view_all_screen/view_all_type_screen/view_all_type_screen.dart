import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/in_use_screen/page/main_page/controller/MainPageController.dart';
import 'package:destinymain/in_use_screen/view_all_screen/view_all_type_screen/view_all_type_appbar.dart';
import 'package:destinymain/no_login_screen/preview_screen/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../data/product/ProductType.dart';
import '../../page/main_page/final_data/mainpage_final_data.dart';
import '../../page/main_page/ingredient/product_type_area/ingredient/item/item_product_type.dart';
import '../../page/main_page/ingredient/product_type_area/ingredient/item/item_product_type_loading.dart';
import '../view_all_product_in_type/view_all_product_in_type.dart';

class view_all_type_screen extends StatefulWidget {
  const view_all_type_screen({super.key});

  @override
  State<view_all_type_screen> createState() => _view_all_type_screenState();
}

class _view_all_type_screenState extends State<view_all_type_screen> {
  List<ProductType> typeList = [];
  bool loading = false;

  Future<void> _refresh() async {
    setState(() {
      loading = true;
    });
    typeList = await MainPageController.getAllProductType();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -width/3 - 20,
              right: -width/2.5,
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
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  title: view_all_type_appbar(),
                ),
                backgroundColor: Colors.transparent,
                body: !loading ? RefreshIndicator(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15,),
                          child: typeList.isNotEmpty ? Container(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // số phần tử trên mỗi hàng
                                mainAxisSpacing: 8, // khoảng cách giữa các hàng
                                crossAxisSpacing: 15, // khoảng cách giữa các cột
                                childAspectRatio: 165/192,
                              ),
                              itemCount: typeList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: item_product_type(productType: typeList[index]),
                                  onTap: () {
                                    print(typeList[index].name);
                                    generalController.changeScreenFade(context, view_all_product_in_type(productType: typeList[index], beforeWidget: widget));
                                  },
                                );
                              },
                            ),
                          ) : Container(
                            alignment: Alignment.center,
                            child: Text(
                              'There are no categories here.',
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
                      childAspectRatio: 165/192,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: item_product_type_loading(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        if (finalData.account.id != '') {
          generalController.changeScreenSlide(context, main_screen());
        } else {
          generalController.changeScreenSlide(context, preview_screen());
        }
        return false;
      },
    );
  }
}
