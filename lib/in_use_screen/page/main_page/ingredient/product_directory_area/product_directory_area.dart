import 'package:destinymain/data/product/ProductDirectory.dart';
import 'package:destinymain/general_ingredient/product_item/horizontal_product_item.dart';
import 'package:destinymain/in_use_screen/page/main_page/ingredient/product_directory_area/ingredient/product_directory_title.dart';
import 'package:flutter/material.dart';
import '../../../../../data/product/Product.dart';
import 'controller/ProductDirectoryController.dart';

class product_directory_area extends StatefulWidget {
  final ProductDirectory productDirectory;
  const product_directory_area({super.key, required this.productDirectory});

  @override
  State<product_directory_area> createState() => _product_directory_areaState();
}

class _product_directory_areaState extends State<product_directory_area> {
  List<Product> productList = [];
  bool loading = false;
  Future<void> _refresh() async {
    setState(() {
      loading = true;
    });
    productList = await ProductDirectoryController.get_product_list_by_direct_id(widget.productDirectory.id, () {setState(() {loading = false;});});
    setState(() {

    });
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15,),
            child: product_directory_title(productDirectory: widget.productDirectory,),
          ),

          Container(
            height: ((width - 45)/2)/2*3 + 20,
            child: ListView.builder(
              itemCount: productList.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: horizontal_product_item(product: productList[index]),
                );
              },
            ),
          ),

          SizedBox(height: 8,),
        ],
      ),
    );
  }
}
