import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class show_Order {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Show_number_Item(int number) {
    StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('card')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          var _theDocs = snapshot.data!.docs;

          number = _theDocs.length;
          print('number of item in card is $number');
          return Container();
        }
        return Container();
      },
    );
    return number;
  }
}
