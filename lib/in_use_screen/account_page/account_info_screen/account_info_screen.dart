import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/finalData.dart';
import '../../../general_ingredient/utils/utils.dart';
import '../../main_screen/main_screen.dart';
import 'ingredient/account_info_app_bar.dart';
import 'ingredient/edit_text_in_account.dart';

class account_info_screen extends StatefulWidget {
  const account_info_screen({super.key});

  @override
  State<account_info_screen> createState() => _account_info_screenState();
}

class _account_info_screenState extends State<account_info_screen> {
  bool loading = false;
  TextEditingController referral_controller = TextEditingController();
  TextEditingController firstname_controller = TextEditingController();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController yourmail_controller = TextEditingController();
  TextEditingController phonenum_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();

  bool _cancontinue() {
    if (firstname_controller.text.isNotEmpty && lastname_controller.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    referral_controller.text = finalData.account.referralCode;
    firstname_controller.text = finalData.account.firstName;
    lastname_controller.text = finalData.account.lastName;
    yourmail_controller.text = finalData.account.username;
    phonenum_controller.text = finalData.account.phoneNum;
    address_controller.text = finalData.account.address;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -width/2,
                top: -50,
                child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/image/decor/bubbles3.png'),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: -width/2,
                bottom: 200,
                child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/image/decor/bubbles3.png'),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: account_info_app_bar(),
                      ),

                      SizedBox(height: 20,),

                      Expanded(
                        child: Container(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: edit_text_in_account(textEditingController: firstname_controller, event: () {}, title: finalLanguage.mainLang.firstName, hint: finalLanguage.mainLang.firstName, readOnly: false,),
                              ),

                              SizedBox(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: edit_text_in_account(textEditingController: lastname_controller, event: () {}, title: finalLanguage.mainLang.lastName, hint: finalLanguage.mainLang.lastName, readOnly: false,),
                              ),

                              SizedBox(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: edit_text_in_account(textEditingController: yourmail_controller, event: () {}, title: finalLanguage.mainLang.yourEmail, hint: finalLanguage.mainLang.yourEmail, readOnly: true,),
                              ),

                              SizedBox(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: edit_text_in_account(textEditingController: phonenum_controller, event: () {}, title: finalLanguage.mainLang.phoneNumber, hint: finalLanguage.mainLang.phoneNumber, readOnly: false,),
                              ),

                              SizedBox(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: edit_text_in_account(textEditingController: address_controller, event: () {}, title: finalLanguage.mainLang.yourAddress, hint: finalLanguage.mainLang.yourAddress, readOnly: false,),
                              ),

                              SizedBox(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: edit_text_in_account(textEditingController: referral_controller, event: () {}, title: 'Your referral code', hint: finalLanguage.mainLang.yourAddress, readOnly: true,),
                              ),

                              SizedBox(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 0, 76, 255)),
                                    ),
                                    onPressed: () async {
                                      setState(() {loading = true;});
                                      finalData.account.firstName = firstname_controller.text.isNotEmpty ? firstname_controller.text.toString() : '';
                                      finalData.account.lastName = lastname_controller.text.isNotEmpty ? lastname_controller.text.toString() : '';
                                      finalData.account.phoneNum = phonenum_controller.text.isNotEmpty ? phonenum_controller.text.toString() : '';
                                      finalData.account.address = address_controller.text.isNotEmpty ? address_controller.text.toString() : '';
                                      DatabaseReference database = FirebaseDatabase.instance.ref("Account");
                                      await database.child(finalData.account.id).set(finalData.account.toJson());
                                      setState(() {loading = false;});
                                      toastMessage(finalLanguage.mainLang.updateSuccess);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: !loading ? Text(
                                        finalLanguage.mainLang.saveInformation,
                                        style: TextStyle(
                                          fontFamily: 'rale',
                                          color: Colors.white,
                                          fontSize: width/23,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ) : CircularProgressIndicator(color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                    onPressed: () {
                                      generalController.changeScreenFade(context, main_screen());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: !loading ? Text(
                                        finalLanguage.mainLang.cancel,
                                        style: TextStyle(
                                          fontFamily: 'rale',
                                          color: Colors.black,
                                          fontSize: width/23,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ) : CircularProgressIndicator(color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      onWillPop: () async {
        generalController.changeScreenFade(context, main_screen());
        return true;
        },
    );
  }
}
