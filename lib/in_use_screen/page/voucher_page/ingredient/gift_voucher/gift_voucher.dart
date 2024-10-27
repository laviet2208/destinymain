import 'package:destinymain/data/finalLanguage.dart';
import 'package:destinymain/no_login_screen/loading_screen/controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../data/Account/Account.dart';
import '../../../../../data/voucherData/Voucher.dart';
import '../../../../../data/finalData.dart';
import '../../../../../general_ingredient/text_field_login.dart';
import '../../../../../general_ingredient/utils/utils.dart';
import '../../../../../no_login_screen/login_screen/loginController.dart';
import '../../../../page/cart_page/check_out/check_out_controller.dart';


class gift_voucher extends StatefulWidget {
  final Voucher voucher;
  final VoidCallback event;
  const gift_voucher({super.key, required this.voucher, required this.event,});

  @override
  State<gift_voucher> createState() => _gift_voucherState();
}

class _gift_voucherState extends State<gift_voucher> {
  bool loading1 = false;
  bool loading2 = false;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text(finalLanguage.mainLang.giftThisVoucher, style: TextStyle(fontSize: 15, fontFamily: 'muli', color: Colors.black,),),
      content: Container(
        width: width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: text_field_login(controller: emailController, hint: finalLanguage.mainLang.enterReceiverEmail, event: () {}, iconData: Icons.person_2_outlined,),
                  ),

                  Container(
                    width: 10,
                  ),

                  GestureDetector(
                    child: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: !loading1 ? Icon(Icons.check, color: Colors.black,) : CircularProgressIndicator(color: Colors.black,),
                    ),
                    onTap: () async {
                      if (emailController.text.isNotEmpty) {
                        if (emailController.text.toString() == finalData.account.username) {
                          toastMessage('Error: Receiver must not yourself');
                        } else {
                          setState(() {
                            loading1 = true;
                          });
                          Account acc = await loginController.getAccountData(emailController.text.toString());
                          if (acc.id != "") {
                            acc.voucherList.add(widget.voucher);
                            finalData.account.voucherList.removeAt(check_out_controller.get_voucher_index(widget.voucher));
                            DatabaseReference database = FirebaseDatabase.instance.ref("Account");
                            await database.child(acc.id).set(acc.toJson());
                            database = FirebaseDatabase.instance.ref("Account");
                            await database.child(finalData.account.id).set(finalData.account.toJson());
                            widget.event();
                            toastMessage('Update Complete');
                            setState(() {
                              loading1 = false;
                            });
                            Navigator.of(context).pop();
                          } else {
                            setState(() {
                              loading1 = false;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(finalLanguage.mainLang.accountDoesNotExist),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
