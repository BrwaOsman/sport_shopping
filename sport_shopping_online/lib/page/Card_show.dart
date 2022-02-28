// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/model/Crad_model.dart';

class Card_show extends StatefulWidget {
  const Card_show({Key? key}) : super(key: key);

  @override
  _Card_showState createState() => _Card_showState();
}

class _Card_showState extends State<Card_show> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ScrollController _scrollController = new ScrollController();

  Color? otherColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'),
      ),
      body: Column(children: <Widget>[
        // Text("data"),
          StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('usres')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('card')
          .snapshots(),
      //  stream: _fireStor.getDataUser(null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        // print(snapshot.data!.size);
        if (snapshot.data != null) {
         var _theDocs =  snapshot.data!.docs.map((e) => CardModel.fromMap(e.data())).toList();

          // List<DocumentSnapshot> _docs = snapshot.data!.docs;
          // if (_scrollController.hasClients) {
          //   _scrollController
          //       .jumpTo(_scrollController.position.minScrollExtent);
          // }
       

          return Expanded(
            child: ListView.builder(
                reverse: false,
                // shrinkWrap: true,
                controller: _scrollController,
                itemCount: _theDocs.length,
                itemBuilder: (context, index) {
                  String typeColors = _theDocs[index].color!;
                  String valueString = typeColors
                      .split('(0x')[1]
                      .split(')')[0]; // kind of hacky..
                  int value = int.parse(valueString, radix: 16);
                  otherColor = new Color(value);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          '${_theDocs[index].image}',
                          width: 50,
                          height: 100,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                _theDocs[index].name!,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('size'),
                            ],
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60 / 2),
                            color: otherColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[400],
                            ),
                            child: Text(
                              "\$${_theDocs[index].price}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                      ],
                    ),
                  );
                }),
          );
        } else {
          print("object");
          return Center(child: CircularProgressIndicator());
        }
      },
          ),
      ]),
    );
  }

  ///await firestore
  // .collection('users')
  // .doc(FirebaseAuth.instance.currentUser!.uid)
  // .collection('card')
  // .add(cardModel.toMap());

  // Widget show_card(User? user) {
  //   );
  
  // }
}
