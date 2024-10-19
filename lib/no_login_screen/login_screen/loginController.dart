import 'package:destinymain/data/finalData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../data/Account/Account.dart';
import '../../data/otherData/Time.dart';
import '../../general_ingredient/utils/utils.dart';

class loginController {
  static Future<void> loginHandleWeb(String email, String password, VoidCallback successEvent, VoidCallback failEvent) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        finalData.account = await getAccountData(email);
        if (finalData.account.id != '') {
          if (finalData.account.lockstatus == 1) {
            successEvent();
          } else {
            failEvent();
            toastMessage('Your account has been locked');
          }
        } else {
          failEvent();
          toastMessage('Please check your email and password');
        }
      } else {
        failEvent();
        toastMessage('Please verify your email before logging in.');
        // You can also send a verification email again if needed
        if (user != null) {
          await user.sendEmailVerification();
        }
      }
    } catch (error) {
      failEvent();
      toastMessage(error.toString());
      print(error.toString());
    }
  }

  static Future<Account> getAccountData(String email) async {
    Account account = Account(id: '', username: '', password: '', address: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), money: 0, firstName: '', lastName: '', phoneNum: '', lockstatus: 0, voucherList: [],);
    print('đã khởi tạo account');
    final reference = FirebaseDatabase.instance.ref();
    print('đã khởi tạo ref');
    DatabaseEvent snapshot = await reference.child("Account").orderByChild('username').equalTo(email).once();
    final dynamic data = snapshot.snapshot.value;
    if (data != null) {
      print('True');
      data.forEach((key, value) {
        account = Account.fromJson(value);
      });
    }
    return account;
  }
}