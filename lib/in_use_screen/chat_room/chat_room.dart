import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../data/chatData/chatRoom.dart';
import '../../../../../data/chatData/messenger.dart';
import '../../../data/finalData.dart';
import '../main_screen/main_screen.dart';
import 'ingredient/Item_messenger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class chatRoomScreen extends StatefulWidget {
  const chatRoomScreen({Key? key}) : super(key: key);

  @override
  State<chatRoomScreen> createState() => _chatRoomScreenState();
}

class _chatRoomScreenState extends State<chatRoomScreen> {
  chatRoom room = chatRoom(account: finalData.account, messengerList: []);
  String base64image = '';
  final ImagePicker _picker = ImagePicker();

  Future<String> uploadBase64Image({required String base64Data, String bucket = 'destinyusa', String folder = '',}) async {
    final bytes = base64Decode(base64Data);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final path = folder.isNotEmpty ? '$folder/$fileName' : fileName;
    print('đây là path: ' + path);
    try {
      final String storedPath = await Supabase.instance.client.storage.from(bucket).uploadBinary(path, bytes);
      print('đây là storedpath: ' + storedPath);
      final String publicUrl = Supabase.instance.client.storage.from(bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      throw Exception('Upload thất bại: $e');
    }
  }

  // Future<void> _pickImageAndConvert() async {
  //   try {
  //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final bytes = await image.readAsBytes();
  //     final base64Str = base64Encode(bytes);
  //     setState(() {
  //       base64image = base64Str;
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Lỗi khi chọn ảnh: $e')),
  //     );
  //   }
  // }

  Future<void> _pickImageAndConvert() async {
    try {
      // Mở dialog chỉ cho chọn file ảnh
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true, // để trả về luôn Uint8List bytes
      );

      // Nếu user hủy thì result sẽ null
      if (result == null) return;

      // Lấy file đầu tiên
      final PlatformFile file = result.files.first;

      // Cố lấy bytes từ file.bytes
      Uint8List? bytes = file.bytes;

      // Nếu bytes null (ví dụ với một số cấu hình), thì đọc từ đường dẫn path
      if (bytes == null && file.path != null) {
        bytes = await File(file.path!).readAsBytes();
      }

      // Nếu vẫn null thì throw lỗi
      if (bytes == null) {
        throw Exception('Không thể đọc dữ liệu ảnh');
      }

      // Encode bytes lên Base64
      final String base64Str = base64Encode(bytes);

      setState(() {
        base64image = base64Str;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi chọn ảnh: $e')),
      );
    }
  }

  bool Loading = false;
  void getChatRoom() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Chatrooms").child(finalData.account.id).onValue.listen((event) async {
      final dynamic Chatrooms = event.snapshot.value;
      if(Chatrooms != null) {
        room = chatRoom.fromJson(Chatrooms);
        setState(() {

        });
      }
    });
  }

  Future<void> pushChatRooms(chatRoom room) async {
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("Chatrooms").child(finalData.account.id).set(room.toJson());
  }

  final messengerText = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blueGrey,),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),(route) => false,);
            },
          ),
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Destiny USA Support',
                        style: TextStyle(
                          fontFamily: 'muli',
                          fontSize: 100,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5)
                          )
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 20,
                          bottom: 20,
                          right: 5,
                          child: GestureDetector(
                            child: Container(
                              width: 40,
                              child:!Loading ? Icon(
                                Icons.send,
                                color: messengerText.text.isNotEmpty ? Colors.blue : Colors.grey,
                              ) : CircularProgressIndicator(color: Colors.blue,),
                            ),
                            onTap: () async {
                              if (messengerText.text.isNotEmpty) {
                                messenger mes = messenger(type: 1, content: messengerText.text.toString());
                                room.messengerList.add(mes);
                                setState(() {
                                  Loading = true;
                                });
                                await pushChatRooms(room);

                                setState(() {
                                  Loading = false;
                                  messengerText.clear();
                                });
                              }
                            },
                          )
                      ),

                      Positioned(
                        top: 20,
                        bottom: 20,
                        left: 10,
                        right: 70,
                        child: TextFormField(
                          controller: messengerText,
                          onChanged: (newValue) => setState(() {}),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'roboto',
                          ),
                          decoration: InputDecoration(
                            // Đổi Icon thành InkWell để bắt tap
                            prefixIcon: IconButton(
                              icon: Icon(Icons.image_outlined),
                              onPressed: () async {
                                await _pickImageAndConvert();
                                if (base64image != '') {
                                  setState(() {
                                    Loading = true;
                                  });
                                  String uploadURL = await uploadBase64Image(base64Data: base64image, folder: 'chatRooms/' + finalData.account.id);
                                  messenger mes = messenger(type: 1, content: uploadURL);
                                  room.messengerList.add(mes);
                                  await pushChatRooms(room);
                                  setState(() {
                                    Loading = false;
                                  });
                                }
                              },
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            hintText: 'Enter text here',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'roboto',
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 10,
                bottom: 85,
                left: 10,
                right: 10,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: room.messengerList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Item_messenger(mes: room.messengerList[index]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),(route) => false,);
        return true;
      },
    );
  }
}