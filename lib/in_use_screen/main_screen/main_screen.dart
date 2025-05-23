import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/in_use_screen/account_page/account_page.dart';
import 'package:destinymain/in_use_screen/page/main_page/main_page.dart';
import 'package:destinymain/in_use_screen/page/notice_page/notice_page.dart';
import 'package:destinymain/in_use_screen/page/voucher_page/ingredient/individual_voucher_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../data/Account/Account.dart';
import '../../data/finalData.dart';
import '../../data/otherData/Tool.dart';
import '../page/cart_page/cart_page.dart';
import '../page/voucher_page/voucher_page.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  Widget getBody(int index) {
    if (index == 0) {
      return main_page();
    }
    if (index == 1) {
      return account_page(event: () { setState(() {}); },);
    }
    if (index == 2) {
      return cart_page();
    }
    if (index == 3) {
      return notice_page();
    }
    if (index == 4) {
      // return voucher_page();
      return voucher_page();
    }
    return Container();
  }

  void get_account_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Account").child(finalData.account.id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      finalData.account = Account.fromJson(data);
    });
  }

  @override
  void initState() {
    print('end: ' + getAllATimeString(getCurrentTime()));
    super.initState();
    get_account_data();
    if (finalData.account.lockstatus == 2) {

    } else {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("Account").child(finalData.account.id).child('lockstatus').set(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        // ),
        backgroundColor: Color.fromARGB(255, 240, 241, 242),
        body: getBody(finalData.currentPage),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Color.fromARGB(255, 0, 76, 255).withOpacity(0.2),
                labelTextStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'muli',
                  ),
                ),
                backgroundColor: Colors.transparent,
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              ),
              child: NavigationBar(
                height: 70,
                selectedIndex: finalData.currentPage,
                onDestinationSelected: (selectedPage) => setState(() {
                  finalData.currentPage = selectedPage;
                }),
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home_outlined, color: finalData.currentPage == 0 ? Colors.black : Colors.black, size: 22,), label: finalLanguage.mainLang.home,),
                  NavigationDestination(icon: Icon(Icons.account_circle_outlined, color: finalData.currentPage == 1 ? Colors.black : Colors.black, size: 22,), label: finalLanguage.mainLang.account,),
                  NavigationDestination(icon: Icon(Icons.add_shopping_cart, color: finalData.currentPage == 2 ? Colors.black : Colors.black, size: 22,), label: finalLanguage.mainLang.cart,),
                  NavigationDestination(icon: Icon(Icons.notifications_none, color: finalData.currentPage == 3 ? Colors.black : Colors.black, size: 22,), label: finalLanguage.mainLang.notification,),
                  NavigationDestination(icon: Icon(Icons.discount_outlined), label: finalLanguage.mainLang.voucher,),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );  }
}
