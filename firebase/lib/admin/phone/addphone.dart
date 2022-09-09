import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class AddPhone extends StatefulWidget {
  const AddPhone({Key? key}) : super(key: key);

  @override
  State<AddPhone> createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptonController = TextEditingController();
  XFile? _phoneImage;
  String? imageUrl;
  chooseImageFromGC() async {
    ImagePicker _picker = ImagePicker();
    _phoneImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  writeData() async {
    File imageFile = File(_phoneImage!.path);

    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask _uploadTask =
        _storage.ref("phone").child(_phoneImage!.name).putFile(imageFile);

    TaskSnapshot snapshot = await _uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();

    CollectionReference _phoneData =
        FirebaseFirestore.instance.collection("phone");

    _phoneData.add({
      "name": _nameController.text,
      "price": _priceController.text,
      "description": _descriptonController.text,
      "img": imageUrl
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: "Enter Phone Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                  hintText: "Enter Phone Price",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _descriptonController,
              decoration: InputDecoration(
                  hintText: "Enter Phone Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
                    child: _phoneImage == null
                        ? IconButton(
                            onPressed: () {
                              chooseImageFromGC();
                            },
                            icon: Icon(Icons.photo))
                        : Image.file(File(_phoneImage!.path)))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  writeData();
                },
                child: Text("Add Phone"))
          ],
        ),
      ),
    );
  }
}
