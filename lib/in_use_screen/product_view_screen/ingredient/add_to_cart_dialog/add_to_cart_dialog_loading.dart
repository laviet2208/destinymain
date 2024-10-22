import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class add_to_cart_dialog_loading extends StatelessWidget {
  const add_to_cart_dialog_loading({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20,),

          Container(
            height: 100,
            child: Row(
              children: [
                SizedBox(width: 10,),

                Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.white,
                  enabled: true,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: ListView(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.white,
                          enabled: true,
                          child: Container(
                            width: width/3*1.8,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.white,
                          enabled: true,
                          child: Container(
                            width: width/3*1.8,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.white,
                          enabled: true,
                          child: Container(
                            width: width/3*1.8,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10,),
              ],
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 0.5,
            decoration: BoxDecoration(
              color: Colors.grey,
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
                children: ['           ', '           ', '           '].map((text) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 249, 249, 249),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: width/30,
                        fontFamily: 'raleb',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          SizedBox(height: 10,),
        ],
      ),
    );  }
}
