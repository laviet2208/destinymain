import 'package:flutter/material.dart';
import '../../../../../data/voucherData/Voucher.dart';
import 'flash_voucher_select.dart';

class in_flash_voucher_select extends StatefulWidget {
  final Voucher voucher;
  final double cost;
  final VoidCallback ontap;
  const in_flash_voucher_select({super.key, required this.voucher, required this.cost, required this.ontap});

  @override
  State<in_flash_voucher_select> createState() => _in_flash_voucher_selectState();
}

class _in_flash_voucher_selectState extends State<in_flash_voucher_select>  with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        // height: height/2,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Uncheck voucher',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent
                        ),
                      ),
                      onTap: () {
                        widget.voucher.changeToDefault();
                        widget.ontap();
                        Navigator.of(context).pop();
                      },
                    ),

                    Container(width: 20,),

                    GestureDetector(
                      child: Text(
                        'Close   ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Scaffold(
                // appBar: AppBar(
                //   automaticallyImplyLeading: false,
                //   backgroundColor: Colors.white,
                //   elevation: 0,
                //   title: SizedBox.shrink(),
                //   flexibleSpace: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       TabBar(
                //         controller: _tabController,
                //         labelColor: Colors.black,
                //         indicatorColor: Colors.transparent,
                //         onTap: (index) {
                //           setState(() {
                //             indexTab = index;
                //           });
                //         },
                //         dividerColor: Colors.white,
                //         indicatorSize: TabBarIndicatorSize.tab,
                //         labelStyle: TextStyle(fontFamily: 'muli', fontWeight: FontWeight.bold), // TextStyle của văn bản khi được chọn
                //         padding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 5),
                //         indicator: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           color: Colors.blueGrey.withOpacity(0.2),
                //         ),
                //         tabs: [
                //           Tab(text: 'General Voucher'),
                //           Tab(text: 'Individual Voucher'),
                //         ],
                //       ),
                //     ],
                //
                //   ),
                // ),
                body: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: flash_voucher_select(voucher: widget.voucher, cost: widget.cost, ontap: widget.ontap,),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
