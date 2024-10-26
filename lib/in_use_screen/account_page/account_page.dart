import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:destinymain/in_use_screen/account_page/account_info_screen/account_info_screen.dart';
import 'package:destinymain/in_use_screen/account_page/ingredient/account_page_appbar.dart';
import 'package:destinymain/in_use_screen/account_page/ingredient/feature_button.dart';
import 'package:destinymain/in_use_screen/history_order/history_order_screen.dart';
import 'package:destinymain/in_use_screen/wallet_info/wallet_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/chatData/chatRoom.dart';
import '../../data/chatData/messenger.dart';
import '../../general_ingredient/utils/utils.dart';
import '../../no_login_screen/loading_screen/loadingController.dart';
import '../chat_room/chat_room.dart';
import 'ingredient/language_change.dart';

class account_page extends StatefulWidget {
  final VoidCallback event;
  const account_page({super.key, required this.event});

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {
  bool loading = false;
  chatRoom room = chatRoom(account: finalData.account, messengerList: []);
  Future<void> getChatRoom() async {
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("Chatrooms").child(finalData.account.id).onValue.listen((event) async {
      final dynamic Chatrooms = event.snapshot.value;
      if(Chatrooms != null) {
        room = chatRoom.fromJson(Chatrooms);
        await pushChatRooms(room);
      } else {
        room = chatRoom(account: finalData.account, messengerList: []);
        room.messengerList.add(messenger(type: 2, content: "Hello, this is Destiny USA's customer service department, how can we help you?"));
        await pushChatRooms(room);
      }
    });
  }

  Future<void> pushChatRooms(chatRoom room) async {
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("Chatrooms").child(finalData.account.id).set(room.toJson());
  }

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
                            finalLanguage.mainLang.personal,
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
                        child: feature_button(iconData: Icons.account_circle_outlined, title: finalLanguage.mainLang.profile, event: () { generalController.changeScreenSlide(context, account_info_screen()); },),
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
                        child: feature_button(iconData: Icons.account_balance_wallet_outlined, title: finalLanguage.mainLang.yourWallet, event: () { generalController.changeScreenSlide(context, wallet_info()); },),
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
                        child: feature_button(iconData: Icons.history, title: finalLanguage.mainLang.historyOrders, event: () { generalController.changeScreenSlide(context, history_order_screen()); },),
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
                        child: feature_button(iconData: Icons.chat_outlined, title: finalLanguage.mainLang.customerCare, event: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.all(10),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                content: Container(
                                  width: width - 80,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(height: 15,),

                                      Padding(
                                        padding: EdgeInsets.only(left: 15, right: 15),
                                        child: GestureDetector(
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.blueAccent.withOpacity(0.7)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.send,
                                                      color: Colors.white,
                                                    ),

                                                    Container(width: 10,),

                                                    Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        'Telegram',
                                                        style: TextStyle(
                                                            fontFamily: 'rale',
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            // launch("https://t.me/Buysmart_support");
                                          },
                                        ),
                                      ),

                                      Container(height: 15,),

                                      Padding(
                                        padding: EdgeInsets.only(left: 15, right: 15),
                                        child: GestureDetector(
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.yellow.shade600
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    !loading ? Icon(
                                                      Icons.chat_sharp,
                                                      color: Colors.black,
                                                    ) : CircularProgressIndicator(color: Colors.black,strokeWidth: 15,),

                                                    Container(width: 10,),

                                                    Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        finalLanguage.mainLang.inAppSupport,
                                                        style: TextStyle(
                                                            fontFamily: 'rale',
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            setState(() {
                                              loading = false;
                                            });
                                            await getChatRoom();
                                            setState(() {
                                              loading = false;
                                            });
                                            generalController.changeScreenSlide(context, chatRoomScreen());
                                          },
                                        ),
                                      ),

                                      Container(height: 15,),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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
                        child: feature_button(iconData: Icons.logout_outlined, title: finalLanguage.mainLang.logOut, event: () async {
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
                        child: feature_button(iconData: Icons.delete_outline_sharp, title: finalLanguage.mainLang.requestAccountDeletion, event: () async {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          finalData.account.id = '';
                          finalData.account.username = '';
                          finalData.account.voucherList.clear();
                          await _auth.signOut();
                          toastMessage(finalLanguage.mainLang.pleaseAllow57Days);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
                        },),
                      ),

                      SizedBox(height: 22,),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            finalLanguage.mainLang.features,
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
                        child: feature_button(iconData: Icons.notifications_active_outlined, title: finalLanguage.mainLang.notification, event: () { finalData.currentPage = 3; widget.event(); },),
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
                        child: feature_button(iconData: Icons.percent, title: finalLanguage.mainLang.yourVouchers, event: () { finalData.currentPage = 4; widget.event(); },),
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
                        child: feature_button(iconData: Icons.shopping_cart_outlined, title: finalLanguage.mainLang.yourCart, event: () { finalData.currentPage = 2; widget.event(); },),
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
                        child: feature_button(iconData: Icons.language, title: finalLanguage.mainLang.language, event: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return language_change(event: () {setState(() {});});
                            },
                          );
                        },),
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
