import '../Account/Account.dart';
import '../otherData/Time.dart';

class MoneyRequest {
  String id;
  Account owner;
  double money;
  Time createTime;
  String walletAdd;
  String status; //A: chưa xử lý, B: đã duyệt, C: đã từ chối
  int type; //1: nạp, 2: rút

  MoneyRequest({required this.id, required this.owner, required this.status, required this.createTime, required this.money, required this.type, required this.walletAdd});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'status': status,
    'money': money,
    'owner': owner.toJson(),
    'createTime': createTime.toJson(),
    'type': type,
    'walletAdd': walletAdd,
  };

  factory MoneyRequest.fromJson(Map<dynamic, dynamic> json) {
    return MoneyRequest (
      id: json['id'].toString(),
      status: json['status'].toString(),
      owner: Account.fromJson(json['owner']),
      createTime: Time.fromJson(json['createTime']),
      money: double.parse(json['money'].toString()),
      type: int.parse(json['type'].toString()),
      walletAdd: json['walletAdd'].toString(),
    );
  }
}