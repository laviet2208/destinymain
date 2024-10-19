import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/page/main_page/controller/MainPageController.dart';
import 'package:destinymain/in_use_screen/page/main_page/final_data/mainpage_final_data.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/ads_area/ads_area.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/ads_area/ads_area_loading.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/app_bar/main_page_app_bar.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_directory_area/loading/product_directory_area_loading.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_directory_area/product_directory_area.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_type_area/product_type_area.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/top_product_area.dart';
import 'package:destinymain/no_login_screen/loading_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../../data/product/ProductDirectory.dart';
import '../../general_ingredient/normal_button.dart';

class preview_screen extends StatefulWidget {
  const preview_screen({super.key});

  @override
  State<preview_screen> createState() => _preview_screenState();
}

class _preview_screenState extends State<preview_screen> {
  bool loading1 = false;
  bool loading2 = false;
  bool loading3 = false;
  bool loading4 = false;
  bool loading5 = false;

  Future<void> _refresh() async {
    mainpage_final_data.adsList.clear();
    mainpage_final_data.typeList.clear();
    mainpage_final_data.topProduct.clear();
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
    setState(() {loading2 = false;});
    mainpage_final_data.topProduct = await MainPageController.getTopProduct();
    setState(() {loading3 = false;});
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
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

                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Want to use more features ?',
                        style: TextStyle(
                          fontFamily: 'rale',
                          fontSize: width/28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: normal_button(backgroundColor: Color.fromARGB(255, 0, 76, 255), overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Use your account now !", contentColor: Colors.white, padding: 0,
                        event: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => welcome_screen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                var begin = 0.0;
                                var end = 1.0;
                                var curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                return FadeTransition(
                                  opacity: animation.drive(tween),
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 500), // Độ dài của hiệu ứng
                            ),
                          );
                        },
                      ),
                    ),

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
                            child: product_directory_area(productDirectory: mainpage_final_data.directory_list[index]),
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
