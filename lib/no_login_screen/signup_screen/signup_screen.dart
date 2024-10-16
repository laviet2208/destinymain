import 'package:destinymain/general_ingredient/normal_textfield.dart';
import 'package:destinymain/general_ingredient/password_textfield.dart';
import 'package:flutter/material.dart';
import '../../general_ingredient/normal_button.dart';
import '../loading_screen/welcome_screen.dart';
import 'background.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

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
                            'Create \nAccount',
                            style: TextStyle(
                              fontSize: width/10,
                              color: Colors.black,
                              fontFamily: 'nuni',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: height/4,),

                        normal_textfield(controller: emailController, hint: 'Your email', event: () {}),

                        SizedBox(height: 10,),

                        password_textfield(controller: passController, hint: 'Password', event: () {}),

                        SizedBox(height: 10,),

                        normal_textfield(controller: firstnameController, hint: 'Your first name', event: () {}),

                        SizedBox(height: 10,),

                        normal_textfield(controller: lastnameController, hint: 'Your last name', event: () {}),

                        SizedBox(height: 10,),

                        normal_button(backgroundColor: Color.fromARGB(255, 0, 76, 255), overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Done", event: () {  }, contentColor: Colors.white, padding: 0,),

                        SizedBox(height: 10,),

                        normal_button(backgroundColor: Colors.white, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Cancel", contentColor: Colors.black, padding: 0,
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
