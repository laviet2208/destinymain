import 'package:flutter/material.dart';
import '../../../../data/finalData.dart';
import '../../../../data/finalLanguage.dart';
import 'voucher_individual_item.dart';

class individual_voucher_page extends StatefulWidget {
  const individual_voucher_page({super.key});

  @override
  State<individual_voucher_page> createState() => _individual_voucher_pageState();
}

class _individual_voucher_pageState extends State<individual_voucher_page> {

  Future<void> _refresh() async {
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: ListView(
              padding: EdgeInsets.only(top: 10),
              children: [
                finalData.account.voucherList.isNotEmpty ? Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: finalData.account.voucherList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: voucher_individual_item(voucher: finalData.account.voucherList[index], event: () { setState(() {}); },),
                      );
                    },
                  ),
                ) : Container(height: 200, alignment: Alignment.center, child: Text(finalLanguage.mainLang.thereAreNotVoucherInHere, style: TextStyle(color: Colors.black),),),
              ],
            ),
          ),
        ),
        onRefresh: _refresh,
      ),
    );
  }
}
