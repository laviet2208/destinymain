import 'package:auto_size_text/auto_size_text.dart';
import 'package:destinymain/data/finalLanguage.dart';
import 'package:flutter/material.dart';

import '../../../../data/finaldata.dart';

class his_voucher_appbar extends StatelessWidget {
  const his_voucher_appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  finalLanguage.mainLang.voucherhistory,
                  style: TextStyle(
                    fontFamily: 'raleb',
                    fontSize: 100,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
