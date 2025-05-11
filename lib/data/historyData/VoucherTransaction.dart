import 'package:destinymain/data/otherData/Time.dart';
import 'package:destinymain/data/voucherData/Voucher.dart';

class VoucherTransactionHis {
  String id;
  Time createTime;
  Voucher voucher;
  String sender;
  String receiver;

  VoucherTransactionHis({required this.id, required this.createTime, required this.sender, required this.receiver, required this.voucher});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'createTime': createTime.toJson(),
    'sender': sender,
    'receiver': receiver,
    'voucher': voucher.toJson(),
  };

  factory VoucherTransactionHis.fromJson(Map<dynamic, dynamic> json) {
    return VoucherTransactionHis (
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      sender: json['sender'].toString(),
      receiver: json['receiver'].toString(),
      voucher: Voucher.fromJson(json['voucher'])
    );
  }
}