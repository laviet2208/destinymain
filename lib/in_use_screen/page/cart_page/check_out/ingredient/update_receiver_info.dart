import 'package:destinymain/data/finalLanguage.dart';
import 'package:flutter/material.dart';
import '../../../../../data/finalData.dart';
import '../../../../../data/orderData/Order.dart';
import '../../../../../general_ingredient/utils/utils.dart';
import 'edit_text_in_signup_step_1.dart';

class update_receiver_info extends StatefulWidget {
  final Order order;
  final VoidCallback event;
  const update_receiver_info({super.key, required this.order, required this.event});

  @override
  State<update_receiver_info> createState() => _update_receiver_infoState();
}

class _update_receiver_infoState extends State<update_receiver_info> {
  final nameController = TextEditingController();
  final districtController = TextEditingController();
  // final cityController = TextEditingController();
  // final provinceController = TextEditingController();
  // final nationController = TextEditingController();
  // final podCodeController = TextEditingController();
  final phoneController = TextEditingController();
  // final addressController = TextEditingController();

  bool _cansave() {
    if (nameController.text.isNotEmpty && districtController.text.isNotEmpty &&
        phoneController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.order.receiver.name;
    districtController.text = widget.order.receiver.district;
    // cityController.text = widget.order.receiver.city;
    // provinceController.text = widget.order.receiver.province;
    // nationController.text = widget.order.receiver.nation;
    // podCodeController.text = widget.order.receiver.podcode;
    phoneController.text = widget.order.receiver.phoneNumber;
    // addressController.text = widget.order.receiver.address;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text('Update Receiver', style: TextStyle(fontFamily: 'muli', fontSize: width/25, fontWeight: FontWeight.bold),),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.white,
      content: Container(
        width: width - 20,
        height: height/2.5,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
              child: edit_text_in_signup_step_1(controller: nameController, hint: finalLanguage.mainLang.pleaseAddYourName, event: () {setState(() {});  },),
            ),

            SizedBox(height: 10,),

            SizedBox(
              height: 50,
              child: edit_text_in_signup_step_1(controller: districtController, hint: finalLanguage.mainLang.pleaseAddYourDistrict, event: () {setState(() {});  },),
            ),

            // SizedBox(height: 10,),
            //
            // SizedBox(
            //   height: 50,
            //   child: edit_text_in_signup_step_1(controller: cityController, hint: finalData.mainLang.Enteryourcity, event: () {setState(() {});  },),
            // ),
            //
            // SizedBox(height: 10,),
            //
            // SizedBox(
            //   height: 50,
            //   child: edit_text_in_signup_step_1(controller: provinceController, hint: finalData.mainLang.Enteryourprovince, event: () {setState(() {});  },),
            // ),

            SizedBox(height: 10,),

            // SizedBox(
            //   height: 50,
            //   child: edit_text_in_signup_step_1(controller: nationController, hint: 'Enter your nation', event: () {setState(() {});  },),
            // ),
            //
            // SizedBox(height: 10,),

            // SizedBox(
            //   height: 50,
            //   child: edit_text_in_signup_step_1(controller: podCodeController, hint: 'Enter your podcode', event: () {setState(() {});  },),
            // ),
            //
            // SizedBox(height: 10,),

            SizedBox(
              height: 50,
              child: edit_text_in_signup_step_1(controller: phoneController, hint: finalLanguage.mainLang.pleaseAddYourPhoneNum, event: () {setState(() {});  },),
            ),

            SizedBox(height: 10,),

            // SizedBox(
            //   height: 50,
            //   child: edit_text_in_signup_step_1(controller: addressController, hint: 'Enter specific address', event: () {setState(() {});  },),
            // ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (_cansave()) {
              widget.order.receiver.name = nameController.text.toString();
              widget.order.receiver.district = districtController.text.toString();
              // widget.order.receiver.city = cityController.text.toString();
              // widget.order.receiver.nation = nationController.text.toString();
              // widget.order.receiver.podcode = podCodeController.text.toString();
              // widget.order.receiver.province = provinceController.text.toString();
              widget.order.receiver.phoneNumber = phoneController.text.toString();
              // widget.order.receiver.address = addressController.text.toString();
              widget.event();
              Navigator.of(context).pop();
            } else {
              toastMessage('Please fill receiver infomation');
            }
          },
          child: Text(
            'Save infomation',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close form',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
