import 'dart:convert';

import 'package:destinymain/data/ProductDataHandle/ProductDataHandle.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/data/otherData/Tool.dart';
import 'package:destinymain/data/product/Product.dart';
import 'package:destinymain/no_login_screen/enter_referral_code_screen/enter_referral_code_screen.dart';
import 'package:destinymain/no_login_screen/loading_screen/loading_screen.dart';
import 'package:destinymain/no_login_screen/lock_screen/lock_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'no_login_screen/loading_screen/welcome_screen.dart';

Future<void> main() async {
  print('Start: ' + getAllATimeString(getCurrentTime()));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //     apiKey: "AIzaSyBcRF7x0mYTbTEwm3C_DTEFOPvhqyX7X-c",
    //     authDomain: "destiny-usa.firebaseapp.com",
    //     databaseURL: "https://destiny-usa-default-rtdb.firebaseio.com",
    //     projectId: "destiny-usa",
    //     storageBucket: "destiny-usa.appspot.com",
    //     messagingSenderId: "96965763722",
    //     appId: "1:96965763722:web:683ba60b8d977c7dbb0373",
    //     measurementId: "G-B7X16QF6RK"
    //   ),
  );
  print('Start1: ' + getAllATimeString(getCurrentTime()));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? language = prefs.getString('language');
  if (language != null) {
    if (language == 'en') {
      finalLanguage.mainLang = finalLanguage.en;
    }
    if (language == 'vi') {
      finalLanguage.mainLang = finalLanguage.vi;
    }
    if (language == 'ko') {
      finalLanguage.mainLang = finalLanguage.ko;
    }
    if (language == 'ja') {
      finalLanguage.mainLang = finalLanguage.ja;
    }
    if (language == 'tq') {
      finalLanguage.mainLang = finalLanguage.tq;
    }
  }
  ProductDataHandle.getAllProductFB();
  // if (await ProductDataHandle.CheckIfFirstTimeEnter()) {
  //   ProductDataHandle.getAllProductFB();
  // } else {
  //
  // }
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // List<String>? productsJson = prefs.getStringList('productList');
  // if (productsJson != null) {
  //   List<Product> prdList = productsJson.map((jsonProduct) => Product.fromJson(jsonDecode(jsonProduct))).toList();
  //   print(prdList[0].name);
  // }
  runApp(const MyApp());
  print('Start2: ' + getAllATimeString(getCurrentTime()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destiny USA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const loading_screen(),
    );
  }
}
