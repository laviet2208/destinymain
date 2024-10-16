import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading_screen extends StatefulWidget {
  const loading_screen({super.key});

  @override
  State<loading_screen> createState() => _loading_screenState();
}

class _loading_screenState extends State<loading_screen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Container(
              width: width - 20,
              height: width - 20,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SpinKitFadingCube(
                      color: Colors.blueAccent.withOpacity(0.1),
                      size: 3*width/5,
                      duration: Duration(milliseconds: 1400),
                    ),
                  ),

                  Center(
                    child: Container(
                      height: 3*width/5,
                      width: 3*width/5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/image/logo/mainlogo.png'),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
