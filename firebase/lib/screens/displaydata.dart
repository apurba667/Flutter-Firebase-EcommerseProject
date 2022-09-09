import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DisplayData extends StatefulWidget {
  const DisplayData({Key? key}) : super(key: key);

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    //for showing data
    final Stream<QuerySnapshot> phoneStream =
        FirebaseFirestore.instance.collection("phone").snapshots();
    return Scaffold(
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
                return Container(
                  height: 200,
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Expanded(child: Image.network(data["img"])),
                        Text(data["name"]),
                        Text(data["price"])
                      ],
                    ),
                  ),
                );
              }).toList());
            }));
  }
}
