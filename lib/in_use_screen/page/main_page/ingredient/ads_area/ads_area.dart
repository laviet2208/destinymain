import 'dart:convert';
import 'dart:typed_data';
import 'package:destinymain/in_use_screen/page/main_page/final_data/mainpage_final_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ads_area extends StatefulWidget {
  const ads_area({super.key});

  @override
  State<ads_area> createState() => _ads_areaState();
}

class _ads_areaState extends State<ads_area> {
  int currentIndex = 0;
  List<Uint8List> imageList = [];
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    for (int i = 0; i < mainpage_final_data.adsList.length; i++) {
      imageList.add(Uint8List.fromList(base64Decode(mainpage_final_data.adsList[i].image)));
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: (width - 30)/2,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: mainpage_final_data.adsList.isNotEmpty ? Container(
                    width: width - 30,
                    height: (width - 30)/2,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width - 30,
                          height: (width - 30)/2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(imageList[index]),
                          ),
                        );
                      },
                    ),
                  ) : Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Colors.white,
                    enabled: true,
                    child: Container(
                      width: width - 30,
                      height: (width - 30)/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: ((width - 30)/2 - 40)/2,
                  right: 5,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    mini: true,
                    child: Icon(Icons.chevron_right, color: Colors.black,),
                    onPressed: () {
                      if (currentIndex < mainpage_final_data.adsList.length - 1) {
                        _controller.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
                      } else {

                      }

                    },
                  ),
                ),

                Positioned(
                  top: ((width - 30)/2 - 40)/2,
                  left: 5,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    mini: true,
                    child: Icon(Icons.chevron_left, color: Colors.black,),
                    onPressed: () {
                      if (currentIndex > 0) {
                        _controller.previousPage(duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
                      } else {

                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 5,),

          Container(
            height: 10,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mainpage_final_data.adsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Container(
                    width: currentIndex == index ? 30 : 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: currentIndex == index ? Color.fromARGB(255, 0, 66, 224) : Color.fromARGB(255, 0, 66, 224).withOpacity(0.3),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

