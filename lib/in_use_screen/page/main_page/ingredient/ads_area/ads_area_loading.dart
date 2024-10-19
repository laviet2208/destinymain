import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ads_area_loading extends StatelessWidget {
  const ads_area_loading({super.key});

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
                  child: Shimmer.fromColors(
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 0, 66, 224).withOpacity(0.3),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );  }
}
