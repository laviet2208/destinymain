import 'package:destinymain/data/finalData.dart';
import 'package:destinymain/data/historyData/VoucherTransaction.dart';
import 'package:destinymain/in_use_screen/history_voucher/his_voucher_appbar.dart';
import 'package:destinymain/in_use_screen/history_voucher/his_voucher_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../data/orderData/Order.dart';
import '../main_screen/main_screen.dart';
// import 'controller/history_order_controller.dart';
// import 'ingredient/his_order_appbar.dart';
// import 'ingredient/his_order_item.dart';
class history_voucher_screen extends StatefulWidget {
  const history_voucher_screen({super.key});

  @override
  State<history_voucher_screen> createState() => _history_voucher_screenState();
}

class _history_voucher_screenState extends State<history_voucher_screen> {
  List<VoucherTransactionHis> hisList = [];

  // Future<List<VoucherTransactionHis>> get_voucher_his_list() async {
  //   List<VoucherTransactionHis> list = [];
  //   final reference = FirebaseDatabase.instance.ref();
  //   DatabaseEvent snapshot = await reference.child("VoucherSendHis").orderByChild('sender').equalTo(finalData.account.id).once();
  //   final dynamic data = snapshot.snapshot.value;
  //   data.forEach((key, value) {
  //     VoucherTransactionHis data = VoucherTransactionHis.fromJson(value);
  //     list.add(data);
  //   });
  //   return list;
  // }

  Future<List<VoucherTransactionHis>> get_voucher_his_list() async {
    final id = finalData.account.id;
    final ref = FirebaseDatabase.instance.ref().child('VoucherSendHis');
    final List<VoucherTransactionHis> list = [];
    final seenKeys = <String>{};

    // Chạy đồng thời 2 query
    final results = await Future.wait([
      ref.orderByChild('sender').equalTo(id).once(),
      ref.orderByChild('receiver').equalTo(id).once(),
    ]);

    for (final event in results) {
      final data = event.snapshot.value;
      if (data is Map) {
        data.forEach((key, value) {
          if (!seenKeys.contains(key)) {
            seenKeys.add(key);
            list.add(VoucherTransactionHis.fromJson(value));
          }
        });
      }
    }

    return list;
  }

  Future<void> _refresh() async {
    hisList = await get_voucher_his_list();
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
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white
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
              right: 0,
              bottom: 0,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  // automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => main_screen()));
                    },
                  ),
                  title: his_voucher_appbar(),
                ),
                body: RefreshIndicator(
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: hisList.length != 0 ? ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(height: 10,),

                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: hisList.length,
                              itemBuilder: (context, index) {
                                return his_voucher_item(voucherTransactionHis: hisList.reversed.toList()[index]);
                              },
                            ),
                          ),
                        ],
                      ) : Text('There are no orders here!', style: TextStyle(fontSize: 14,color: Colors.black),),
                    ),
                  ),
                  onRefresh: _refresh,
                ),
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => main_screen()));
        return true;
      },
    );
  }
}
