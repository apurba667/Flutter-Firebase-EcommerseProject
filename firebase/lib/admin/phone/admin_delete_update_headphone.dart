import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/admin/headphone/add_headphone.dart';
import 'package:firebase/admin/headphone/update_headphone.dart';
import 'package:firebase/admin/phone/addphone.dart';
import 'package:firebase/admin/phone/update_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HeadphoneInsertUpdateDelete extends StatefulWidget {
  const HeadphoneInsertUpdateDelete({Key? key}) : super(key: key);

  @override
  State<HeadphoneInsertUpdateDelete> createState() => _AdminDeleteUpdateState();
}

class _AdminDeleteUpdateState extends State<HeadphoneInsertUpdateDelete> {
  Future<void> deleteCourse(selectDocument) {
    return FirebaseFirestore.instance
        .collection("headphone")
        .doc(selectDocument)
        .delete()
        .then((value) => print("Data has been deleted!"))
        .catchError((e) => print(e));
  }

  Future<void> editPhone(
      selectDocument, phonename, phoneprice, phonedes, phoneimg) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => UpdateHeadphone(
            selectDocument, phonename, phoneprice, phonedes, phoneimg));
  }

  addPhone() {
    //choosing Image from phone

    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => AddHeadphone());
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> phoneStream =
        FirebaseFirestore.instance.collection("headphone").snapshots();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addPhone();
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Welcome To Home Page"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: phoneStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Stack(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Expanded(
                                child: Image.network(
                              data["img"],
                              fit: BoxFit.cover,
                            )),
                            Text(data["name"]),
                            Text(data["price"])
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        right: 0,
                        child: Container(
                          width: 120,
                          child: Card(
                            elevation: 20,
                            color: Colors.green,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      editPhone(
                                          document.id,
                                          data["name"],
                                          data["price"],
                                          data["description"],
                                          data["img"]);
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteCourse(document.id);
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          ),
                        ))
                  ],
                );
              }).toList());
            }));
  }
}
