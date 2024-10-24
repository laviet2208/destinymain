import 'dart:convert';
import 'dart:typed_data';
import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/data/product/Product.dart';
import 'package:flutter/material.dart';
import '../../../data/otherData/Tool.dart';
import '../../../general_ingredient/generalController.dart';

class image_and_name_area extends StatefulWidget {
  final Product product;
  final Widget previousWidget;
  const image_and_name_area({super.key, required this.product, required this.previousWidget});

  @override
  State<image_and_name_area> createState() => _image_and_name_areaState();
}

class _image_and_name_areaState extends State<image_and_name_area> {
  int currentImage = 0;
  String costString = '';
  String costBeforeString = '';
  List<Uint8List> imageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    costString = getCostString(widget.product.dimensionList);
    costBeforeString = getCostBeforeSaleString(widget.product.dimensionList);
    for (int i = 0; i < widget.product.imageList.length; i++) {
      imageList.add(Uint8List.fromList(base64Decode(widget.product.imageList[i])));
    }
    print('Xử lý xong');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///main image
          Container(
            width: width,
            height: width/3*2,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: width,
                    height: width/3*2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(imageList[currentImage]),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 5,
                  left: 5,
                  child: IconButton(
                    onPressed: () {
                      if (finalData.account.id == '') {

                      } else {
                        generalController.changeScreenSlide(context, widget.previousWidget);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 7,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 80,
              child: ListView.builder(
                itemCount: widget.product.imageList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      child: Container(
                        width: 80,
                        height: 80,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(imageList[index]),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: currentImage == index ? Container(
                                height: 20,
                                width: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 76, 255),
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check_outlined,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ) : Container(),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          currentImage = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 7,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontFamily: 'raleb',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width/20,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                costString,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'raleb',
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: width/20,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: costBeforeString,
                      style: TextStyle(
                        fontFamily: 'rale',
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.lineThrough,
                        fontSize: width/28,
                      ),
                    ),

                    TextSpan(
                      text: ' · ',
                      style: TextStyle(
                        fontFamily: 'raleb',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: width/25,
                      ),
                    ),

                    TextSpan(
                      text: getDiscountPercentRange(widget.product.dimensionList),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: width/28,
                        fontFamily: 'rale',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 7,),

          // Padding(
          //   padding: EdgeInsets.only(left: 10, right: 10),
          //   child: Container(
          //     child: Wrap(
          //       spacing: 8.0, //ngang
          //       runSpacing: 8.0, //dọc
          //       alignment: WrapAlignment.start,
          //       children: widget.product.dimensionList.map((text) {
          //         return Container(
          //           padding: const EdgeInsets.all(8.0), // Padding bên trong cho đẹp
          //           decoration: BoxDecoration(
          //             color: Color.fromARGB(255, 249, 249, 249),
          //             borderRadius: BorderRadius.circular(3.0),
          //           ),
          //           child: Text(
          //             text.name,
          //             style: TextStyle(
          //               color: Color.fromARGB(255, 0, 0, 0),
          //               fontSize: width/30,
          //               fontFamily: 'raleb',
          //             ),
          //           ),
          //         );
          //       }).toList(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
