import 'dart:async';
import 'package:destinymain/no_login_screen/loading_screen/welcome_screen.dart';
import 'package:destinymain/no_login_screen/login_screen/loginController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/finalData.dart';
import '../../data/otherData/Tool.dart';
import '../../general_ingredient/utils/utils.dart';
import '../../in_use_screen/main_screen/main_screen.dart';

class loadingController {
  static Future<void> isLoginWeb(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        finalData.account = await loginController.getAccountData(user.email.toString());
        print('Get account: ' + getAllATimeString(getCurrentTime()) + ':' + DateTime.now().millisecond.toString());
        if (finalData.account.id != '') {
          Timer(const Duration(seconds: 3) , () => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => main_screen())));
        } else {
          toastMessage('Please check your email and password');
          Timer(const Duration(seconds: 3) , () => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => welcome_screen())));
        }
      } else {
        print('email chưa xác minh');
        Timer(const Duration(seconds: 3) , () => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => welcome_screen())));
      }
    } else {
      Timer(const Duration(seconds: 3) , () => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => welcome_screen())));
    }
  }
}