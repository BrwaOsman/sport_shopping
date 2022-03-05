// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/model/Crad_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


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
      backgroundColor: Colors.grey[400], 
      appBar: AppBar(
        title: Text('Show Card', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey[400],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        // Text("data"),
          StreamBuilder<QuerySnapshot>(
            
      stream: _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('card').
          orderBy('quantity', descending: true)
          .snapshots(),
      //  stream: _fireStor.getDataUser(null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        // print(snapshot.data!.size);
        if (snapshot.data != null) {
         var _theDocs =  snapshot.data!.docs.map((e) => CardModel.fromMap(e.data())).toList();

          List<DocumentSnapshot> _docs = snapshot.data!.docs;
          if (_scrollController.hasClients) {
            _scrollController
                .jumpTo(_scrollController.position.minScrollExtent);
          }
       print(snapshot.data!.docs.length);

          return Expanded(
            child: ListView.builder(
                reverse: false,
                // shrinkWrap: true,
                controller: _scrollController,
                itemCount: _theDocs.length,
                itemBuilder: (context, index) {
                  String typeColors = "${_theDocs[index].color}";
                  String valueString = typeColors
                      .split('(0x')[1]
                      .split(')')[0]; // kind of hacky..
                  int value = int.parse(valueString, radix: 16);
                  otherColor = new Color(value);
                List<DocumentSnapshot> _docs = snapshot.data!.docs;

                  return show_card(_theDocs, index, _docs);
                }),
          );
        } else {
          print("object");
          return Center(child: CircularProgressIndicator());
        }
      },
          ),
    ElevatedButton(onPressed:() {
      
    } , child: Text('Send Card',style:TextStyle(color: Colors.black,fontFamily: 'Nisebuschgardens') ),
    style:ElevatedButton.styleFrom(
      padding: EdgeInsets.only(left: 50,right: 50,top: 15,bottom: 15),
      primary: Colors.white
    ) ,),
    SizedBox(height: 20,),
      ],),

    );
  }

  Padding show_card(List<CardModel> _theDocs, int index, List<DocumentSnapshot> _docs) {
    return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(10), 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            actions: [
              IconSlideAction(
                caption: 'Delete',
                color: Colors.white,
                icon: Icons.delete,
                onTap: () {
                  show_delet(index, _docs);
                },
              )
            ],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                             width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _theDocs[index].image!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            // child: Image.network(
                            //   '${_theDocs[index].image}',
                            //   width: 50,
                            //   height: 80,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    _theDocs[index].name!,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left ,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Size : "+ _theDocs[index].size!),
                                     Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60 / 2),
                              color: otherColor,
                            ),
                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                         
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price ',
                            style: TextStyle(
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _theDocs[index].price.toString()+" \$",
                            style: TextStyle(
                                fontSize: 16,),
                          ),
                        ],
                      )
                        ],
                      ),
                    ),
                  ),
                );
  }

  show_delet(int index, List<DocumentSnapshot> _docs) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            width: 200,
            height: 150,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Positioned(
                        left: 100,
                        child: InkResponse(
                          child: CircleAvatar(
                            child: Center(
                                child: Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.red,
                            )),
                            backgroundColor: Colors.white,
                          ),
                        )),
                  ),
                  Center(
                    child: Text("Are you sure you have delete it ?"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          _firestore
                              .collection("users").doc(_auth.currentUser!.uid).collection("card").doc(_docs[index].id).delete();

                          Navigator.of(context).pop();
                        },
                        child: Text("Delete"),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancle"))),
                    ],
                  )
                ]),
          ),
        );
      },
    );
  }
}
