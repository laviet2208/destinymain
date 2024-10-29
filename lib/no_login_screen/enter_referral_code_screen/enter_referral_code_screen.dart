import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/general_ingredient/utils/utils.dart';
import 'package:destinymain/in_use_screen/main_screen/main_screen.dart';
import 'package:destinymain/no_login_screen/enter_referral_code_screen/enterReferralController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/finalData.dart';
import '../../general_ingredient/normal_button.dart';
import '../../general_ingredient/normal_textfield.dart';
import '../loading_screen/loading_screen.dart';
import '../login_screen/background.dart';

class enter_referral_code_screen extends StatefulWidget {
  const enter_referral_code_screen({super.key});

  @override
  State<enter_referral_code_screen> createState() => _enter_referral_code_screenState();
}

class _enter_referral_code_screenState extends State<enter_referral_code_screen> {
  final referralController = TextEditingController();
  bool loading = false;
  bool can_continue() {
    if (referralController.text.isEmpty) {
      return false;
    }
    return true;
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
                            'Referral Code',
                            style: TextStyle(
                              fontSize: width/10,
                              color: Colors.black,
                              fontFamily: 'nuni',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please use referral code for first time log in into the application! ♥',
                            style: TextStyle(
                              fontSize: width/24,
                              color: Colors.black,
                              fontFamily: 'nuni',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        normal_textfield(controller: referralController, hint: 'Your referral code', event: () {setState(() {});}),

                        SizedBox(height: 20,),

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
                                  setState(() {
                                    loading = true;
                                  });
                                  bool check = await enterReferralController.checkReferralCode(referralController.text.toString());
                                  if (check) {
                                    generalController.changeScreenSlide(context, main_screen());
                                  } else {
                                    toastMessage('Wrong code');
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                } else {
                                  toastMessage('Enter code to continue');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7, bottom: 7),
                                child: !loading ? Text(
                                  'Continue',
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

                        normal_button(backgroundColor: Colors.transparent, overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), borderRadius: 10, content: "Log out", contentColor: Colors.red, padding: 0,
                          event: () async {
                            final FirebaseAuth _auth = FirebaseAuth.instance;
                            finalData.account.id = '';
                            finalData.account.username = '';
                            finalData.account.voucherList.clear();
                            await _auth.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);

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
        return false;
      },
    );  }
}
