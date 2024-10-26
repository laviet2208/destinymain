import 'package:destinymain/data/product/ProductType.dart';
import 'package:destinymain/in_use_screen/view_all_screen/view_all_product_in_type/view_all_in_type_appbar.dart';
import 'package:flutter/material.dart';

import '../../../data/finalData.dart';
import '../../../data/product/Product.dart';
import '../../../general_ingredient/generalController.dart';
import '../../../general_ingredient/product_item/horizontal_product_item.dart';
import '../../../general_ingredient/product_item/horizontal_product_item_loading.dart';
import '../../../no_login_screen/preview_screen/preview_screen.dart';
import '../view_all_product_indirectory/viewAllProductController.dart';

class view_all_product_in_type extends StatefulWidget {
  final ProductType productType;
  final Widget beforeWidget;
  const view_all_product_in_type({super.key, required this.productType, required this.beforeWidget});

  @override
  State<view_all_product_in_type> createState() => _view_all_product_in_typeState();
}

class _view_all_product_in_typeState extends State<view_all_product_in_type> {
  List<Product> productList = [];
  bool loading = false;
  Future<void> _refresh() async {
    if (finalData.isComplete) {
      productList = finalData.allProductList.where((x) => x.productType == widget.productType.id).toList();
      setState(() {

      });
    } else {
      setState(() {
        loading = true;
      });
      productList = await viewAllProductController.get_product_list_by_type_id(widget.productType.id, () {setState(() {loading = false;});});
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
                  title: view_all_in_type_appbar(name: widget.productType.name, beforeWidget: widget.beforeWidget,),
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
          generalController.changeScreenFade(context, widget.beforeWidget);
        } else {
          generalController.changeScreenFade(context, preview_screen());
        }
        return false;
      },
    );
  }
}
