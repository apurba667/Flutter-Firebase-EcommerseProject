import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HeadphoneData extends StatefulWidget {
  const HeadphoneData({Key? key}) : super(key: key);

  @override
  State<HeadphoneData> createState() => _HeadphoneDataState();
}

class _HeadphoneDataState extends State<HeadphoneData> {
  String inputData() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return user.email.toString();
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    //for showing data
    final Stream<QuerySnapshot> phoneStream =
        FirebaseFirestore.instance.collection("headphone").snapshots();
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Welcome ${inputData()}",
          style: TextStyle(color: Colors.black),
        ),
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
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                height: 200,
                child: Card(
                  color: Colors.redAccent,
                  elevation: 10,
                  child: Row(
                    children: [
                      Expanded(
                          child: Image.network(
                        data["img"],
                        fit: BoxFit.cover,
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            data["name"],
                            style: TextStyle(fontSize: 26),
                          ),
                          Text(data["price"])
                        ],
                      ))
                    ],
                  ),
                ),
              );
            }).toList());
          }),
    );
  }
}
