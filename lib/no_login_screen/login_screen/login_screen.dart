import 'package:flutter/material.dart';
import '../../general_ingredient/normal_button.dart';
import '../../general_ingredient/normal_textfield.dart';
import '../loading_screen/welcome_screen.dart';
import 'background.dart';
import 'login_step_2_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final emailController = TextEditingController();

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
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: width/8,
                              color: Colors.black,
                              fontFamily: 'nuni',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Good to see you back! ♥',
                            style: TextStyle(
                              fontSize: width/24,
                              color: Colors.black,
                              fontFamily: 'nuni',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        normal_textfield(controller: emailController, hint: 'Your email', event: () {}),

                        SizedBox(height: 20,),

                        normal_button(backgroundColor: Color.fromARGB(255, 0, 76, 255), overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Next", contentColor: Colors.white, padding: 0,
                          event: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => login_step_2_screen(),
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
                            );
                          },
                        ),

                        SizedBox(height: 10,),

                        normal_button(backgroundColor: Colors.transparent, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Cancel", contentColor: Colors.black, padding: 0,
                          event: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => welcome_screen(), // Màn hình đích
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
            pageBuilder: (context, animation, secondaryAnimation) => welcome_screen(), // Màn hình đích
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
