import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/data/historyData/VoucherTransaction.dart';
import 'package:destinymain/in_use_screen/page/cart_page/ingredient/cost_text_line.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/finalData.dart';
import '../../../../data/orderData/Order.dart';
import '../../../../data/otherData/Tool.dart';
import '../../../general_ingredient/utils/utils.dart';
// import '../../page/cart_page/ingredient/cost_text_line.dart';
// import 'view_product_list.dart';

class his_voucher_item extends StatefulWidget {
  final VoucherTransactionHis voucherTransactionHis;
  const his_voucher_item({super.key, required this.voucherTransactionHis});

  @override
  State<his_voucher_item> createState() => _his_order_itemState();
}

class _his_order_itemState extends State<his_voucher_item> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8,),

          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.voucherTransactionHis.sender == finalData.account.id ? "Sent a voucher" : "Received a voucher",
              style: TextStyle(
                fontFamily: 'rale',
                fontSize: width/30,
                fontWeight: FontWeight.bold,
                color: widget.voucherTransactionHis.sender == finalData.account.id ? Colors.red : Colors.green,
              ),
            ),
          ),

          SizedBox(height: 8,),

          cost_text_line(title: 'Created time: ', content: getAllTimeString(widget.voucherTransactionHis.createTime), size: width/30, contentColor: Colors.black, titleColor: Colors.grey,),

          SizedBox(height: 4,),

          cost_text_line(title: 'Receiver ID: ', content: widget.voucherTransactionHis.receiver, size: width/30, contentColor: Colors.black, titleColor: Colors.grey,),

          SizedBox(height: 4,),

          Padding(
            padding: EdgeInsets.only(left: 0, right: 0),
            child: Container(
              height: 1,
              decoration: BoxDecoration(color: Colors.grey,),
            ),
          ),

          SizedBox(height: 4,),

          cost_text_line(title: 'Event Name: ', content: widget.voucherTransactionHis.voucher.eventName, size: width/30, contentColor: Colors.black, titleColor: Colors.grey,),

          SizedBox(height: 4,),

          cost_text_line(title: 'Voucher value: ', content: getStringNumber(widget.voucherTransactionHis.voucher.Money), size: width/30, contentColor: Colors.black, titleColor: Colors.grey,),

          SizedBox(height: 4,),

          cost_text_line(title: 'Voucher code: ', content: widget.voucherTransactionHis.voucher.id, size: width/30, contentColor: Colors.black, titleColor: Colors.grey,),

          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
