import 'package:destinymain/in_use_screen/page/main_page/controller/MainPageController.dart';
import 'package:destinymain/in_use_screen/page/main_page/final_data/mainpage_final_data.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/ads_area/ads_area.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/app_bar/main_page_app_bar.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_type_area/product_type_area.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/top_product_area/top_product_area.dart';
import 'package:destinymain/no_login_screen/loading_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class preview_screen extends StatefulWidget {
  const preview_screen({super.key});

  @override
  State<preview_screen> createState() => _preview_screenState();
}

class _preview_screenState extends State<preview_screen> {
  bool loading = false;

  Future<void> _refresh() async {
    // setState(() {loading = true;});
    mainpage_final_data.adsList = await MainPageController.getAdsData();
    // setState(() {loading = true;});
    mainpage_final_data.typeList = await MainPageController.getProductType();
    setState(() {loading = true;});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: main_page_app_bar(),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: RefreshIndicator(
              child: Container(
                decoration: BoxDecoration(

                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 10,),

                    ads_area(),

                    SizedBox(height: 15,),

                    product_type_area(),

                    SizedBox(height: 15,),

                    top_product_area(),
                  ],
                ),
              ),
              onRefresh: _refresh,
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context,
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
            }, transitionDuration: Duration(milliseconds: 500), // Độ dài của hiệu ứng
          ),
        );
        return true;
      },
    );
  }
}
