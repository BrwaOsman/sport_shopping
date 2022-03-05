// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sport_shopping_online/model/favorite_model.dart';
import 'package:sport_shopping_online/model/prodect_model.dart';

import '../model/Crad_model.dart';

class MyFavotite extends StatefulWidget {
  const MyFavotite({Key? key}) : super(key: key);

  @override
  State<MyFavotite> createState() => _MyFavotiteState();
}

class _MyFavotiteState extends State<MyFavotite> {
  
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
        title: Text(
          'My Favorite',
          style: TextStyle(color: Colors.black, fontFamily: 'Nisebuschgardens'),
        ),
        backgroundColor: Colors.grey[400],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
               .collection("users").doc(user!.uid).collection("favorite")
                .snapshots(),
            //  stream: _fireStor.getDataUser(null),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              }
              // print(snapshot.data!.size);
              if (snapshot.data != null) {
                var _theDocs = snapshot.data!.docs
                    .map((e) => FavoriteModel.fromMap(e.data()))
                    .toList();
                  var getId = snapshot.data!.docs;
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
                        // String typeColors = "${_theDocs[index].color}";
                        // String valueString = typeColors
                        //     .split('(0x')[1]
                        //     .split(')')[0]; // kind of hacky..
                        // int value = int.parse(valueString, radix: 16);
                        // otherColor = new Color(value);

                        return show_card(_theDocs, index, getId, user);
                      }),
                );
              } else {
                print("object");
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
 

  Padding show_card(List<FavoriteModel> _theDocs, int index, List<DocumentSnapshot> getId, User? user) {

    print(_theDocs[index].size!.length);
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
              caption: 'unfavorite',
              color: Colors.white,
              icon: Icons.favorite,
              onTap: () {
                _firestore
                     .collection("users").doc(user!.uid).collection("favorite")
                     .doc(getId[index].id)
                    .delete();
              },
            ),
          
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        _theDocs[index].name!,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Text("Size : ${_theDocs[index].size![index]}",style: TextStyle(fontSize: 15),),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   scrollDirection: Axis.horizontal,
                        //   itemCount: _theDocs[index].sizes!.length,
                        //   itemBuilder: (context, index) {
                        //     return Text(
                        //       "Size : ",
                        //       style: TextStyle(fontSize: 15),
                        //     );
                        //   },
                        // ),
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
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _theDocs[index].price.toString() + " \$",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
