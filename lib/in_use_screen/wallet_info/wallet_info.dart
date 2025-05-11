import 'package:auto_size_text/auto_size_text.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/general_ingredient/generalController.dart';
import 'package:flutter/material.dart';
import '../../../../../data/finaldata.dart';
import '../../../data/historyData/Transaction.dart';
import '../../../data/otherData/Tool.dart';
import '../main_screen/main_screen.dart';
import 'controller/wallet_controller.dart';
import 'ingredient/Withdrawal_requirements_form/Withdrawal_requirements_choice.dart';
import 'ingredient/card_info.dart';
import 'ingredient/change_to_customer_care.dart';
import 'ingredient/item_history_transaction.dart';
import 'ingredient/text_line_in_profile.dart';
import 'ingredient/wallet_appbar.dart';

class wallet_info extends StatefulWidget {
  const wallet_info({super.key});

  @override
  State<wallet_info> createState() => _wallet_infoState();
}

class _wallet_infoState extends State<wallet_info> {
  bool loading = false;
  List<TransactionHis> hisList = [];

  Future<void> _refresh() async {
    hisList = await wallet_controller.get_his_list();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -width/3 - 70,
                right: -width/2.5,
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
                left: 0,
                bottom: 0,
                right: 0,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        generalController.changeScreenSlide(context, main_screen());
                      },
                    ),
                    title: wallet_appbar(),
                  ),
                  body: RefreshIndicator(
                    child: Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      // ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ListView(
                          children: [
                            SizedBox(height: 10,),

                            card_info(),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  TextButton(
                                    child: Text(
                                      finalLanguage.mainLang.deposit,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'rale',
                                        fontSize: 14,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 54, 121, 125)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0), // Đặt BorderRadius ở đây
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return change_to_customer_care();
                                        },
                                      );
                                    },
                                  ),

                                  SizedBox(width: 10,),

                                  TextButton(
                                    child: Text(
                                      finalLanguage.mainLang.withdraw,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'rale',
                                        fontSize: 14,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.redAccent),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0), // Đặt BorderRadius ở đây
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Withdrawal_requirements_choice();
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20,),

                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),

                            Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                height: 25,
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  finalLanguage.mainLang.historyTransaction,
                                  style: TextStyle(
                                    fontFamily: 'raleb',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 100,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),

                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: hisList.length,
                                itemBuilder: (context, index) {
                                  return item_history_transaction(his: hisList.reversed.toList()[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onRefresh: _refresh,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => main_screen()));
        return true;
      },
    );
  }
}
