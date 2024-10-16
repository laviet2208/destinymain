import 'package:flutter/material.dart';

class background extends StatelessWidget {
  const background({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/image/decor/bubbles2.png'),
          )
      ),
    );
  }
}
