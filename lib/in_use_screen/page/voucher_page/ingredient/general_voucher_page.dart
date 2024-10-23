import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../data/voucherData/Voucher.dart';
import '../controller/voucher_page_controller.dart';
import 'voucher_item.dart';

class general_voucher_page extends StatefulWidget {
  const general_voucher_page({super.key});

  @override
  State<general_voucher_page> createState() => _general_voucher_pageState();
}

class _general_voucher_pageState extends State<general_voucher_page> {
  bool loading = false;
  List<Voucher> voucherList = [];
  Future<void> _refresh() async {
    setState(() {
      loading = true;
    });
    voucherList = await voucher_page_controller.get_voucher_list();
    setState(() {
      loading = false;
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
    double height = MediaQuery.of(context).size.height;
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
                !loading ? Container(
                  child: voucherList.length != 0 ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: voucherList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: voucher_item(voucher: voucherList[index]),
                      );
                    },
                  ) : Container(height: 200, alignment: Alignment.center, child: Text('There are not voucher in here', style: TextStyle(color: Colors.black),),),
                ) : Container(
                  height: height - 200,
                  alignment: Alignment.center,
                  child: SpinKitWanderingCubes(color: Color.fromARGB(255, 0, 68, 255), size: 30,),
                ),
              ],
            ),
          ),
        ),
        onRefresh: _refresh,
      ),
    );
  }
}
