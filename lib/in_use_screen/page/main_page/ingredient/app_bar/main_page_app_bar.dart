import 'package:flutter/material.dart';

class main_page_app_bar extends StatelessWidget {
  const main_page_app_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          SizedBox(width: 0,),

          Text(
            'Destiny USA',
            style: TextStyle(
              fontFamily: 'rale',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(width: 10,),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Color.fromARGB(255, 248, 248, 248),
              ),
              child: Row(
                children: [
                  SizedBox(width: 15,),

                  Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontFamily: 'rale',
                          color: Color.fromARGB(255, 199, 199, 199),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  Expanded(child: Container()),

                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 66, 224),
                    ),
                  ),

                  SizedBox(width: 15,),
                ],
              ),
            ),
          ),

          SizedBox(width: 0,),
        ],
      ),
    );
  }
}
