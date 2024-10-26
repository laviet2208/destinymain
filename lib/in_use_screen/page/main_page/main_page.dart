import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/flashsale_button/flashsale_button.dart';
import 'package:flutter/material.dart';
import '../../../data/product/ProductDirectory.dart';
import '../../../general_ingredient/generalController.dart';
import '../../../no_login_screen/loading_screen/welcome_screen.dart';
import 'controller/MainPageController.dart';
import 'final_data/mainpage_final_data.dart';
import 'ingredient/ads_area/ads_area.dart';
import 'ingredient/ads_area/ads_area_loading.dart';
import 'ingredient/app_bar/main_page_app_bar.dart';
import 'ingredient/product_directory_area/loading/product_directory_area_loading.dart';
import 'ingredient/product_directory_area/product_directory_area.dart';
import 'ingredient/product_type_area/product_type_area.dart';
import 'ingredient/top_product_area/top_product_area.dart';

class main_page extends StatefulWidget {
  const main_page({super.key});

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  bool loading1 = false;
  bool loading2 = false;
  bool loading3 = false;
  bool loading4 = false;
  bool loading5 = false;

  Future<void> _refresh() async {
    mainpage_final_data.adsList.clear();
    mainpage_final_data.typeList.clear();
    mainpage_final_data.topProduct.clear();
    mainpage_final_data.directory_list.clear();
    mainpage_final_data.directory_id_list.clear();
    setState(() {
      loading1 = true;
      loading2 = true;
      loading3 = true;
      loading4 = true;
      loading5 = true;
    });
    mainpage_final_data.adsList = await MainPageController.getAdsData();
    setState(() {loading1 = false;});
    mainpage_final_data.typeList = await MainPageController.getProductType();
    // setState(() {loading2 = false;});
    mainpage_final_data.topProduct = await MainPageController.getTopProduct();
    // setState(() {loading3 = false;});
    mainpage_final_data.directory_id_list = await MainPageController.getDirectoryUi();
    mainpage_final_data.directory_list.clear();
    for (int i = 0; i < mainpage_final_data.directory_id_list.length; i++) {
      ProductDirectory save = await MainPageController.getDirectory(mainpage_final_data.directory_id_list[i]);
      mainpage_final_data.directory_list.add(save);
      print(save.toJson().toString());
      setState(() {
        i == 0 ? loading4 = false : loading5 = false;
      });
    }
    mainpage_final_data.number_open = -1;
    mainpage_final_data.number_open = mainpage_final_data.number_open + 1;
  }

  @override
  void initState() {
    if (mainpage_final_data.number_open > 3 || mainpage_final_data.number_open == -1) {
      _refresh();
    } else {
      mainpage_final_data.number_open = mainpage_final_data.number_open + 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: main_page_app_bar(),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 0),
            child: RefreshIndicator(
              child: Container(
                decoration: BoxDecoration(

                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 10,),

                    !loading1 ? ads_area() : ads_area_loading(),

                    SizedBox(height: 15,),

                    flashsale_button(),

                    SizedBox(height: 15,),

                    product_type_area(),

                    SizedBox(height: 25,),

                    top_product_area(),

                    SizedBox(height: 25,),

                    !loading4 ? Container(
                      child: ListView.builder(
                        itemCount: mainpage_final_data.directory_list.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: product_directory_area(productDirectory: mainpage_final_data.directory_list[index], current: main_screen(),),
                          );
                        },
                      ),
                    ) : Container(
                      child: ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: product_directory_area_loading(),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 25,),
                  ],
                ),
              ),
              onRefresh: _refresh,
            ),
          ),
        ),
      ),
      onWillPop: () async {
        generalController.changeScreenFade(context, welcome_screen());
        return true;
      },
    );
  }
}
