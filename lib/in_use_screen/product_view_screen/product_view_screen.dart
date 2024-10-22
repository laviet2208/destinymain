import 'package:destinymain/data/product/Product.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/product_view_screen/ingredient/add_to_cart_dialog/add_to_cart_dialog.dart';
import 'package:destinymain/in_use_screen/product_view_screen/ingredient/description.dart';
import 'package:destinymain/in_use_screen/product_view_screen/ingredient/image_and_name_area.dart';
import 'package:flutter/material.dart';

class product_view_screen extends StatefulWidget {
  final Product product;
  final Widget previousWidget;
  const product_view_screen({super.key, required this.product, required this.previousWidget});

  @override
  State<product_view_screen> createState() => _product_view_screenState();
}

class _product_view_screenState extends State<product_view_screen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            children: [
              image_and_name_area(product: widget.product, previousWidget: widget.previousWidget,),

              SizedBox(height: 10,),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    child: TextButton(
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(const BorderSide(color: Color.fromARGB(255, 0, 76, 255), width: 1)),
                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(0),
                            ),
                          ),
                          builder: (context) {
                            return add_to_cart_dialog(product: widget.product,);
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            fontFamily: 'raleb',
                            color: Color.fromARGB(255, 0, 76, 255),
                            fontSize: width/25,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              description(content: widget.product.description),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        generalController.changeScreenSlide(context, widget.previousWidget);
        return true;
      },
    );
  }
}
