import 'dart:convert';
import 'dart:typed_data';
import 'package:destinymain/data/cartData/CartData.dart';
import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/data/otherData/Tool.dart';
import 'package:destinymain/data/product/Product.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/general_ingredient/utils/utils.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/in_use_screen/page/cart_page/cart_for_buy_now_screen.dart';
import 'package:destinymain/in_use_screen/product_view_screen/ingredient/add_to_cart_dialog/add_to_cart_dialog_loading.dart';
import 'package:destinymain/in_use_screen/product_view_screen/ingredient/add_to_cart_dialog/ingredient/image_cost_in_add_to_cart.dart';
import 'package:destinymain/in_use_screen/product_view_screen/product_view_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/product/Dimension.dart';
import '../../ProductViewController.dart';

class add_to_cart_for_buy_now extends StatefulWidget {
  final Product product;
  final int type;// 1: cart thường
  const add_to_cart_for_buy_now({super.key, required this.product, required this.type,});

  @override
  State<add_to_cart_for_buy_now> createState() => _add_to_cart_for_buy_nowState();
}

class _add_to_cart_for_buy_nowState extends State<add_to_cart_for_buy_now> {
  bool loading = false;
  List<Dimension> DimensionList = [];
  List<String> imageList = [];
  List<Cartdata> cartList = [];

  Dimension selectDimension = Dimension(name: '', cost: 0, costBfSale: 0, image: '', inventory: 0);
  late String image;
  int numberProduct = 1;

  Future<void> getDimensionList() async {
    setState(() {
      loading = true;
    });
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child('productList').child(widget.product.id).child('dimensionList').once();
    final dynamic data = snapshot.snapshot.value;
    DimensionList.clear();
    imageList.clear();
    if (data != null) {
      for (final result in data) {
        DimensionList.add(Dimension.fromJson(result));
        imageList.add(DimensionList.last.image);
      }
    }
    if (DimensionList.isNotEmpty) {
      selectDimension = DimensionList.first;
      image = imageList.first;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDimensionList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return !loading ? Container(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20,),

          image_cost_in_add_to_cart(image: image, selectDimension: selectDimension),

          SizedBox(height: 10,),

          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: width,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.start,
                children: DimensionList.map((dimension) {
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8.0), // Padding bên trong cho đẹp
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 249, 249),
                        borderRadius: BorderRadius.circular(3.0),
                        border: selectDimension.name == dimension.name ? Border.all(
                          width: 0.5,
                          color: Colors.red,
                        ) : null,
                      ),
                      child: Text(
                        dimension.name,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: width/30,
                          fontFamily: 'raleb',
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectDimension = dimension;
                        image = imageList[DimensionList.indexOf(selectDimension)];
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Number: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.remove, size: 14,),
                      onPressed: () => setState(() {
                        final newValue = numberProduct - 1;
                        numberProduct = newValue.clamp(1, 100);
                      }),
                    ),

                    Text(numberProduct.toString()),

                    IconButton(
                      icon: Icon(Icons.add, size: 14,),
                      onPressed: () => setState(() {
                        final newValue = numberProduct + 1;
                        numberProduct = newValue.clamp(1, 100);
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),

          Container(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.redAccent),
                  overlayColor: WidgetStatePropertyAll<Color>(Colors.black.withOpacity(0.3)),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    'Buy now',
                    style: TextStyle(
                      fontFamily: 'nuni',
                      color: Colors.white,
                      fontSize: width/25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  if (finalData.account.id == '') {
                    toastMessage('You must login to use this feature');
                  } else {
                    ProductViewController.add_to_cart_handle_buy_now(widget.product, selectDimension, numberProduct, widget.type, cartList);
                    print('number:: ' + cartList.length.toString());
                    generalController.changeScreenSlide(context, cart_for_buy_now_screen(cartList: cartList, beforeWidget: product_view_screen(product: widget.product, previousWidget: main_screen(), type: widget.type),));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    ) : add_to_cart_dialog_loading();
  }
}