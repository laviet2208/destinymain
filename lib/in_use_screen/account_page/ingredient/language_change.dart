import 'package:destinymain/data/finalLanguage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../general_ingredient/utils/utils.dart';

class language_change extends StatefulWidget {
  final VoidCallback event;
  const language_change({super.key, required this.event});

  @override
  State<language_change> createState() => _language_changeState();
}

class _language_changeState extends State<language_change> {

  Future<void> saveLang(String key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () async {
                finalLanguage.mainLang = finalLanguage.vi;
                await saveLang('language', 'vi');
                widget.event();
                toastMessage('Cập nhật thành công');
                setState(() {

                });
              },
              autofocus: false,
              child: Container(
                child: Text(
                  'Tiếng Việt',
                  style: TextStyle(
                    fontFamily: 'raleb',
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            TextButton(
              onPressed: () async {
                finalLanguage.mainLang = finalLanguage.en;
                await saveLang('language', 'en');
                widget.event();
                toastMessage('Update success');
                setState(() {

                });
              },
              autofocus: false,
              child: Container(
                child: Text(
                  'English',
                  style: TextStyle(
                    fontFamily: 'raleb',
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            TextButton(
              onPressed: () async {
                finalLanguage.mainLang = finalLanguage.ko;
                await saveLang('language', 'ko');
                widget.event();
                toastMessage('업데이트되었습니다');
                setState(() {

                });
              },
              autofocus: false,
              child: Container(
                child: Text(
                  '한국어',
                  style: TextStyle(
                    fontFamily: 'raleb',
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            TextButton(
              onPressed: () async {
                finalLanguage.mainLang = finalLanguage.ja;
                await saveLang('language', 'ja');
                widget.event();
                toastMessage('正常に更新されました');
                setState(() {

                });
              },
              autofocus: false,
              child: Container(
                child: Text(
                  '日本語',
                  style: TextStyle(
                    fontFamily: 'raleb',
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            TextButton(
              onPressed: () async {
                finalLanguage.mainLang = finalLanguage.ja;
                await saveLang('language', 'tq');
                widget.event();
                toastMessage('更新成功');
                setState(() {

                });
              },
              autofocus: false,
              child: Container(
                child: Text(
                  '中國人',
                  style: TextStyle(
                    fontFamily: 'raleb',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
