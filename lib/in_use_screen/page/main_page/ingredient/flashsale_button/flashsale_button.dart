import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/flash_sale_area/flash_sale_screen/flash_sale_screen.dart';
import 'package:destinymain/in_use_screen/page/main_page/controller/MainPageController.dart';
import 'package:flutter/material.dart';

import '../../../../../data/finalLanguage.dart';

class flashsale_button extends StatelessWidget {
  const flashsale_button({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.deepOrange),
            overlayColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 0, 0, 0).withOpacity(0.1)),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
              ),
            ),
          ),
          onPressed: () async {
            int status = await MainPageController.getFlashSaleStatus();
            if (status == 0) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(finalLanguage.mainLang.oOPSFlashSaleHasntStartedYet, style: TextStyle(fontFamily: 'raleb',fontSize: 15,),),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close', style: TextStyle(color: Colors.blueAccent,),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
            } else {
              generalController.changeScreenFade(context, flash_sale_screen());
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.flash_on_rounded,
                  color: Colors.white,
                ),

                SizedBox(height: 10,),

                Text(
                  finalLanguage.mainLang.flashSaleJointNow,
                  style: TextStyle(
                    fontFamily: 'raleb',
                    color: Colors.white,
                    fontSize: width/22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10,),

                Icon(
                  Icons.flash_on_rounded,
                  color: Colors.white,
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
