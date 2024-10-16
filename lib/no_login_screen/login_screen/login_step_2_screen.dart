import 'package:flutter/material.dart';
import '../../general_ingredient/normal_button.dart';
import '../../general_ingredient/normal_textfield.dart';
import 'background.dart';
import 'login_screen.dart';

class login_step_2_screen extends StatefulWidget {
  const login_step_2_screen({super.key});

  @override
  State<login_step_2_screen> createState() => _login_step_2_screenState();
}

class _login_step_2_screenState extends State<login_step_2_screen> {
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -height/5,
                  left: 0,
                  child: background(),
                ),

                Positioned(
                  top: 0,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            height: width/3,
                            width: width/3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1000),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10.0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/image/decor/avatar.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Hello, Hoang Viet' + ' !',
                            style: TextStyle(
                              fontSize: width/15,
                              color: Colors.black,
                              fontFamily: 'nuni',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Type your password',
                            style: TextStyle(
                              fontSize: width/24,
                              color: Colors.black,
                              fontFamily: 'nuni',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        normal_textfield(controller: passController, hint: 'Your password', event: () {}),

                        SizedBox(height: 20,),

                        normal_button(backgroundColor: Color.fromARGB(255, 0, 76, 255), overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Continue", contentColor: Colors.white, padding: 0,
                          event: () {

                          },
                        ),

                        SizedBox(height: 10,),

                        normal_button(backgroundColor: Colors.transparent, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Not you?", contentColor: Colors.black, padding: 0,
                          event: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => login_screen(), // Màn hình đích
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  var begin = Offset(1.0, 0.0);
                                  var end = Offset.zero;
                                  var curve = Curves.easeOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                                transitionDuration: Duration(milliseconds: 200), // Độ dài của hiệu ứng
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => login_screen(), // Màn hình đích
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.easeOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 200), // Độ dài của hiệu ứng
          ),
        );
        return true;
      },
    );
  }
}
