import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../data/Account/Account.dart';
import '../../../general_ingredient/utils/utils.dart';

class signupController {
  static Future<void> signUpPressed(Account account, VoidCallback trueLoading, VoidCallback falseLoading, VoidCallback changeToLogin) async {
    trueLoading();
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(email: account.username, password: account.password).then((value) {
      auth.currentUser?.sendEmailVerification().then((value) async {
        DatabaseReference database = FirebaseDatabase.instance.ref("Account");
        await database.child(account.id).set(account.toJson()).then((value){
          changeToLogin();
        }).onError((error, stackTrace) {
          falseLoading();
          toastMessage(error.toString());
          print(error.toString());
        });
      }).catchError((error) {
        falseLoading();
        toastMessage(error.toString());
        print('lỗi: ' + error.toString());
      });
    }).catchError((error) {
      toastMessage(error.toString());
      print('lỗi: ' + error.toString());
    });
  }
}