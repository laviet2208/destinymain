import 'package:flutter/material.dart';

import '../../../data/finalData.dart';
import '../../../general_ingredient/generalController.dart';
import '../../../no_login_screen/preview_screen/preview_screen.dart';
import '../../main_screen/main_screen.dart';

class view_all_in_directory_appbar extends StatelessWidget {
  final String name;
  const view_all_in_directory_appbar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          SizedBox(width: 0,),

          IconButton(
            onPressed: () {
              if (finalData.account.id != '') {
                generalController.changeScreenSlide(context, main_screen());
              } else {
                generalController.changeScreenSlide(context, preview_screen());
              }
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
          ),

          SizedBox(width: 10,),

          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'raleb',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
