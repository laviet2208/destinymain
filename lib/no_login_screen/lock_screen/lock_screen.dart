import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/finalData.dart';
import '../../general_ingredient/generalController.dart';
import '../../general_ingredient/normal_button.dart';
import '../loading_screen/loading_screen.dart';

class lock_screen extends StatefulWidget {
  const lock_screen({super.key});

  @override
  State<lock_screen> createState() => _lock_screenState();
}

class _lock_screenState extends State<lock_screen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width/3.5, right: width/3.5),
                child: Container(
                  width: width - 2*(width/3.5),
                  height: width - 2*(width/3.5),
                  child: Icon(
                    Icons.lock_clock_outlined,
                    color: Color.fromARGB(255, 53, 126, 189),
                    size: width - 2.5*(width/3.5),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Sorry, your account has been locked. To continue using the application, please contact our customer service department.',
                    style: TextStyle(
                      fontFamily: 'raleb',
                      color: Colors.black,
                      fontSize: width/24,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: normal_button(backgroundColor: Colors.red, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Log out", contentColor: Colors.white, padding: 0,
                  event: () async {
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    finalData.account.id = '';
                    finalData.account.username = '';
                    finalData.account.voucherList.clear();
                    await _auth.signOut();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
                  },
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: normal_button(backgroundColor: Colors.blue, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Customer care", contentColor: Colors.white, padding: 0,
                  event: () {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
