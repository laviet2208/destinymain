import 'package:flutter/material.dart';

class no_product_container extends StatelessWidget {
  const no_product_container({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: (width - width/2.8)/2, right: (width - width/2.8)/2,),
            child: Container(
              height: width/2.8,
              width: width/2.8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(width/15),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/logo/logonotxt.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Container(
            alignment: Alignment.center,
            child: Text(
              'Your cart is empty',
              style: TextStyle(
                color: Colors.black,
                fontSize: width/25,
                fontFamily: 'rale',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
