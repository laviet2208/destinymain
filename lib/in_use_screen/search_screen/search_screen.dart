import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/in_use_screen/product_view_screen/product_view_screen.dart';
import 'package:flutter/material.dart';
import '../../data/finalData.dart';
import '../../data/product/Product.dart';
import 'ingredient/item_product_search.dart';

class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  final searchController = TextEditingController();
  List<Product> filterList = [];

  void onSearchTextChanged(String value) {
    setState(() {
      filterList = finalData.allProductList
          .where((product) =>
          product.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -width/3 - 100,
                right: -width/2.5 + 100,
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 40,),

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10,),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: 40,
                                    child: Icon(
                                      Icons.keyboard_arrow_left_outlined,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  onTap: () {
                                    generalController.changeScreenSlide(context, main_screen());
                                  },
                                ),

                                SizedBox(width: 10,),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          hintText: 'Search product on Buy smart',
                                          hintStyle: TextStyle(color: Colors.grey[600]),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: onSearchTextChanged,
                                        cursorColor: Colors.blue, // Cursor color
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10,),

                                Container(
                                  width: 40,
                                  child: Icon(
                                    Icons.mic_none,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: filterList.length != 0 ? ListView.builder(
                            itemCount: filterList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  child: item_product_search(product: filterList[index]),
                                  onTap: () {
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => product_view_screen(product: filterList[index], previousWidget: search_screen())));
                                  },
                                ),
                              );
                            },
                          ) : Text('There are no products here', style: TextStyle(fontSize: 14,color: Colors.black),),
                        ),
                      ),

                      SizedBox(height: 0,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        generalController.changeScreenSlide(context, search_screen());
        return true;
      },
    );
  }
}
