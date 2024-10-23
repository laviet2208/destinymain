import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/account_page/account_info_screen/account_info_screen.dart';
import 'package:destinymain/in_use_screen/account_page/ingredient/account_page_appbar.dart';
import 'package:destinymain/in_use_screen/account_page/ingredient/feature_button.dart';
import 'package:destinymain/in_use_screen/wallet_info/wallet_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../general_ingredient/utils/utils.dart';
import '../../no_login_screen/loading_screen/loadingController.dart';

class account_page extends StatefulWidget {
  final VoidCallback event;
  const account_page({super.key, required this.event});

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -width/3 - 100,
              right: -width/2.5 + 100,
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
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: account_page_appbar(),
                ),
                backgroundColor: Colors.transparent,
                body: Container(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Personal',
                            style: TextStyle(
                              fontFamily: 'raleb',
                              color: Colors.black,
                              fontSize: width/18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.account_circle_outlined, title: 'Profile', event: () { generalController.changeScreenSlide(context, account_info_screen()); },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.account_balance_wallet_outlined, title: 'Your wallet', event: () { generalController.changeScreenSlide(context, wallet_info()); },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.history, title: 'History orders', event: () {  },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.chat_outlined, title: 'Customer Care', event: () {  },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.logout_outlined, title: 'Log out', event: () async {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          finalData.account.id = '';
                          finalData.account.username = '';
                          finalData.account.voucherList.clear();
                          await _auth.signOut();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
                        },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.delete_outline_sharp, title: 'Request account deletion', event: () async {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          finalData.account.id = '';
                          finalData.account.username = '';
                          finalData.account.voucherList.clear();
                          await _auth.signOut();
                          toastMessage('Please allow 5-7 days for request processing.');
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
                        },),
                      ),

                      SizedBox(height: 22,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Features',
                            style: TextStyle(
                              fontFamily: 'raleb',
                              color: Colors.black,
                              fontSize: width/18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.notifications_active_outlined, title: 'Notification', event: () { finalData.currentPage = 3; widget.event(); },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.percent, title: 'Your vouchers', event: () { finalData.currentPage = 4; widget.event(); },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.shopping_cart_outlined, title: 'Your cart', event: () { finalData.currentPage = 2; widget.event(); },),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 18,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: feature_button(iconData: Icons.language, title: 'Language', event: () {  },),
                      ),

                      SizedBox(height: 28,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
