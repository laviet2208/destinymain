import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/general_ingredient/utils/utils.dart';
import 'package:destinymain/in_use_screen/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../data/finalLanguage.dart';

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
            child: GestureDetector(
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
                          finalLanguage.mainLang.search,
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
              onTap: () {
                if (finalData.account.id == '') {
                  toastMessage('You must login for use this feature');
                } else {
                  generalController.changeScreenSlide(context, search_screen());
                }
              },
            ),
          ),

          SizedBox(width: 0,),
        ],
      ),
    );
  }
}
