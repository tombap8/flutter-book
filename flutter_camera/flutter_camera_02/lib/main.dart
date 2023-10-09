import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  "사진 저장하기",
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
            ),
            Container(
              child: _selectedImage != null ? Image.file(_selectedImage!) : Text("사진 없음"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt_outlined),
                  iconSize: 50.0,
                ),
                IconButton(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.image_outlined),
                  iconSize: 50.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _takePhoto() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      GallerySaver.saveImage(pickedImage.path).then((bool? success) {
        print(success == true ? "사진이 저장되었습니다" : "사진 저장 오류");
      });
    }
  }
}
