import 'package:destinymain/data/finalLanguage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/MoneyRequest/MoneyRequest.dart';
import '../../../../data/finalData.dart';
import '../../../../general_ingredient/utils/utils.dart';

class enter_email_and_password extends StatefulWidget {
  final MoneyRequest moneyRequest;
  const enter_email_and_password({super.key, required this.moneyRequest});

  @override
  State<enter_email_and_password> createState() => _enter_email_and_passwordState();
}

class _enter_email_and_passwordState extends State<enter_email_and_password> {
  bool loading = false;
  bool _obscureText = true;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 50;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: RichText(
        text: TextSpan(
            children: [
              TextSpan(
                text: finalLanguage.mainLang.verifyAccount + '\n',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'sf',
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: finalLanguage.mainLang.verifyAccounttosubmit,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontFamily: 'sf',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ]
        ),
      ),
      content: Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                  child: TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      filled: true,
                      // border: InputBorder.none,
                      fillColor: Colors.transparent, // Background color when not focused
                      contentPadding: EdgeInsets.all(0),
                      hintText: finalLanguage.mainLang.yourEmail,
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    cursorColor: Color.fromARGB(255, 23, 87, 83),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                  child: TextField(
                    controller: passController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      // border: InputBorder.none,
                      fillColor: Colors.transparent, // Background color when not focused
                      contentPadding: EdgeInsets.only(top: 10),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
                    ),
                    cursorColor: Color.fromARGB(255, 23, 87, 83),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
            onPressed: () async {
              if (userController.text.toString() == finalData.account.username && passController.text.toString() == finalData.account.password) {
                setState(() {
                  loading = true;
                });
                DatabaseReference database = FirebaseDatabase.instance.ref("MoneyRequest");
                await database.child(widget.moneyRequest.id).set(widget.moneyRequest.toJson());
                setState(() {
                  loading = false;
                });
                toastMessage('Submitted successfully, please wait for processing');
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                toastMessage('Email or password is wrong!');
              }
            },
            child: Text(
              'Send request',
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            )
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel request',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            )
        ),
      ],
    );
  }
}
