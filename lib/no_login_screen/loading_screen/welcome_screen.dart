import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/general_ingredient/normal_button.dart';
import 'package:destinymain/no_login_screen/preview_screen/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_screen/login_screen.dart';
import '../signup_screen/signup_screen.dart';

class welcome_screen extends StatefulWidget {
  const welcome_screen({super.key});

  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> {
  List<String> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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

              SizedBox(height: 10,),

              Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Destiny ',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: width/13,
                            fontFamily: 'nuni',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'USA',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: width/13,
                            fontFamily: 'nuni',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: width/7, right: width/7,),
                child: Container(
                  child: Text(
                    'Shop conveniently and spend smartly with Destiny USA.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 32, 32, 32),
                      fontSize: width/25,
                      fontFamily: 'nuni',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height/3,),

              normal_button(backgroundColor: Color.fromARGB(255, 0, 76, 255), overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Let's get started", contentColor: Colors.white, padding: 25,
                event: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => signup_screen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = 0.0;
                        var end = 1.0;
                        var curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                        return FadeTransition(
                          opacity: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500), // Độ dài của hiệu ứng
                    ),
                  );                },
              ),

              SizedBox(height: 10,),

              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'I already have an account',
                          style: TextStyle(
                            fontFamily: 'nuni',
                            fontSize: width/28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(width: 10,),

                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Color.fromARGB(255, 0, 76, 255),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  generalController.changeScreenFade(context, login_screen());
                },
              ),

              SizedBox(height: 10,),

              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Use the app as a guest',
                          style: TextStyle(
                            fontFamily: 'nuni',
                            fontSize: width/28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(width: 10,),

                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => preview_screen()),);
                },
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
