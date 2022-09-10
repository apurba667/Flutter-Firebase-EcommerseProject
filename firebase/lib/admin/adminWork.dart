import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/admin/admin_delete_update_laptop.dart';
import 'package:firebase/admin/admin_delete_update_mobile.dart';
import 'package:firebase/admin/phone/addphone.dart';
import 'package:firebase/admin/phone/admin_delete_update_headphone.dart';
import 'package:firebase/admin/phone/update_phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class AdminWork extends StatefulWidget {
  const AdminWork({Key? key}) : super(key: key);

  @override
  State<AdminWork> createState() => _AdminWordState();
}

class _AdminWordState extends State<AdminWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Admin Panel"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.green,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PhoneInsertUpdateDelete(),
                  ));
                },
                child: Text("Mobile")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LaptopInsertDeleteUpdate(),
                  ));
                },
                child: Text("Laptop")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HeadphoneInsertUpdateDelete(),
                  ));
                },
                child: Text("Headphone"))
          ],
        ),
      ),
    );
  }
}
