import 'package:flutter/material.dart';
class generalController {
  static void changeScreenSlide(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget, // Màn hình đích
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 200), // Độ dài của hiệu ứng
      ),
    );
  }

  static void changeScreenFade(BuildContext context, Widget widget) {
    Navigator.pushReplacement(context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        }, transitionDuration: Duration(milliseconds: 500), // Độ dài của hiệu ứng
      ),
    );
  }
}