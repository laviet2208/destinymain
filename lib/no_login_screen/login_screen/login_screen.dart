import 'package:auto_size_text/auto_size_text.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:flutter/material.dart';
import '../../general_ingredient/normal_button.dart';
import '../../general_ingredient/normal_textfield.dart';
import '../../general_ingredient/utils/utils.dart';
import '../../in_use_screen/main_screen/main_screen.dart';
import '../loading_screen/welcome_screen.dart';
import 'background.dart';
import 'loginController.dart';
import 'login_step_2_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool can_continue() {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

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

                        normal_textfield(controller: passController, hint: 'Your password', event: () {}),

                        SizedBox(height: 5,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: GestureDetector(
                            child: Container(
                              height: 20,
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: AutoSizeText(
                                'Forgot password?',
                                style: TextStyle(
                                  fontFamily: 'rale',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 100,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                        ),

                        SizedBox(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 0, right: 0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(can_continue() ? Color.fromARGB(255, 0, 76, 255) : Colors.grey),
                                overlayColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 0, 0, 0).withOpacity(0.1)),
                                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (can_continue()) {
                                  setState(() {loading = true;});
                                  await loginController.loginHandleWeb(emailController.text.toString(), passController.text.toString(),
                                        () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => main_screen()),);},
                                        () {setState(() {loading = false;});},);
                                } else {
                                  toastMessage('Please fill all information and try again');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7, bottom: 7),
                                child: !loading ? Text(
                                  'Log in',
                                  style: TextStyle(
                                    fontFamily: 'nuni',
                                    color: Colors.white,
                                    fontSize: width/22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) : CircularProgressIndicator(color: Colors.white,),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        normal_button(backgroundColor: Colors.transparent, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Cancel", contentColor: Colors.black, padding: 0,
                          event: () {
                            generalController.changeScreenSlide(context, welcome_screen());
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
        generalController.changeScreenSlide(context, welcome_screen());
        return true;
      },
    );
  }
}
