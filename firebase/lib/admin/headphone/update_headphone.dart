import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class UpdateHeadphone extends StatefulWidget {
  String? documentId;
  String? phoneName;
  String? phonePrice;
  String? phoneDes;
  String? phoneImg;
  UpdateHeadphone(this.documentId, this.phoneName, this.phonePrice,
      this.phoneDes, this.phoneImg);

  @override
  State<UpdateHeadphone> createState() => _UpdateHEadphopneState();
}

class _UpdateHEadphopneState extends State<UpdateHeadphone> {
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

  updateData() async {
    if (_phoneImage == null) {
      CollectionReference _phoneData =
          FirebaseFirestore.instance.collection("headphone");
      _phoneData.doc(widget.documentId).update({
        "name": _nameController.text,
        "price": _priceController.text,
        "description": _descriptonController.text,
        "img": widget.phoneImg
      });
    } else {
      File imageFile = File(_phoneImage!.path);

      FirebaseStorage _storage = FirebaseStorage.instance;
      UploadTask _uploadTask =
          _storage.ref("headphone").child(_phoneImage!.name).putFile(imageFile);

      TaskSnapshot snapshot = await _uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();

      CollectionReference _phoneData =
          FirebaseFirestore.instance.collection("headphone");

      _phoneData.doc(widget.documentId).update({
        "name": _nameController.text,
        "price": _priceController.text,
        "description": _descriptonController.text,
        "img": imageUrl
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _nameController.text = widget.phoneName!;
    _priceController.text = widget.phonePrice!;
    _descriptonController.text = widget.phoneDes!;
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
                        ? Stack(
                            children: [
                              Image.network("${widget.phoneImg}"),
                              CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      chooseImageFromGC();
                                    },
                                    icon: Icon(Icons.photo)),
                              )
                            ],
                          )
                        : Image.file(File(_phoneImage!.path)))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  updateData();
                },
                child: Text("Update headphone"))
          ],
        ),
      ),
    );
  }
}
