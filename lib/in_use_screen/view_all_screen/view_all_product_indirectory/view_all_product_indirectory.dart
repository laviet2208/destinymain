import 'package:destinymain/data/product/ProductDirectory.dart';
import 'package:destinymain/general_ingredient/product_item/horizontal_product_item.dart';
import 'package:destinymain/general_ingredient/product_item/horizontal_product_item_loading.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_directory_area/loading/product_directory_area_loading.dart';
import 'package:destinymain/in_use_screen/view_all_screen/view_all_product_indirectory/viewAllProductController.dart';
import 'package:destinymain/in_use_screen/view_all_screen/view_all_product_indirectory/view_all_in_directory_appbar.dart';
import 'package:flutter/material.dart';

import '../../../data/finalData.dart';
import '../../../data/product/Product.dart';
import '../../../general_ingredient/generalController.dart';
import '../../../no_login_screen/preview_screen/preview_screen.dart';
import '../../main_screen/main_screen.dart';

class view_all_product_indirectory extends StatefulWidget {
  final ProductDirectory productDirectory;
  const view_all_product_indirectory({super.key, required this.productDirectory});

  @override
  State<view_all_product_indirectory> createState() => _view_all_product_indirectoryState();
}

class _view_all_product_indirectoryState extends State<view_all_product_indirectory> {
  List<Product> productList = [];
  bool loading = false;
  Future<void> _refresh() async {
    if (finalData.isComplete) {
      productList = finalData.allProductList.where((x) => x.productDirectory == widget.productDirectory.id).toList();
      setState(() {

      });
    } else {
      setState(() {
        loading = true;
      });
      productList = await viewAllProductController.get_product_list_by_direct_id(widget.productDirectory.id, () {setState(() {loading = false;});});
      setState(() {

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
                  title: view_all_in_directory_appbar(name: widget.productDirectory.name),
                ),
                backgroundColor: Colors.transparent,
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
                                  child: horizontal_product_item(product: productList[index], current: widget, type: 1,),
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
