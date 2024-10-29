import 'dart:math';

import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/general_ingredient/normal_textfield.dart';
import 'package:destinymain/general_ingredient/password_textfield.dart';
import 'package:destinymain/no_login_screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import '../../data/Account/Account.dart';
import '../../data/otherData/Tool.dart';
import '../../general_ingredient/normal_button.dart';
import '../../general_ingredient/utils/utils.dart';
import '../loading_screen/welcome_screen.dart';
import 'background.dart';
import 'controller/signupController.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  bool can_continue() {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty && firstnameController.text.isNotEmpty && lastnameController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  String getRandomString(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQXYZTR123456789';
    final random = Random();
    return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (can_continue()) {
                                  Account account = Account(id: '', username: emailController.text.toString(), password: passController.text.toString(), address: '', createTime: getCurrentTime(), money: 0, firstName: firstnameController.text.toString(), lastName: lastnameController.text.toString(), phoneNum: '', lockstatus: 1, voucherList: [], referralCode: '');
                                  String id = getCurrentTimeString();
                                  account.id = 'TK' + id;
                                  account.referralCode = getRandomString(8);
                                  await signupController.signUpPressed(account,
                                        () {setState(() {loading = true;});},
                                        () {setState(() {loading = false;});},
                                        () {setState(() {loading = false;}); toastMessage('PLease check your email to verify'); generalController.changeScreenFade(context, login_screen());},
                                  );
                                } else {
                                  toastMessage('please fill all infomation');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7, bottom: 7),
                                child: !loading ? Text(
                                  'Done',
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

                        normal_button(backgroundColor: Colors.white, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Cancel", contentColor: Colors.black, padding: 0,
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
