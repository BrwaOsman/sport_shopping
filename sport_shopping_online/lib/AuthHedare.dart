// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/Auth/Login.dart';
import 'package:sport_shopping_online/Auth/Register.dart';
import 'package:sport_shopping_online/Router/Router.dart';
import 'package:sport_shopping_online/page/About.dart';
import 'package:sport_shopping_online/page/Card_show.dart';
import 'package:sport_shopping_online/page/DitalePage.dart';
import 'package:sport_shopping_online/page/Edit_profile.dart';
import 'package:sport_shopping_online/page/Home.dart';
import 'package:sport_shopping_online/page/category.dart';
import 'package:sport_shopping_online/page/myAccount.dart';
import 'package:sport_shopping_online/page/myFavorite.dart';

import 'page/AddProdect.dart';

class AuthHedar extends StatefulWidget {
  const AuthHedar({Key? key}) : super(key: key);

  @override
  _AuthHedarState createState() => _AuthHedarState();
}

class _AuthHedarState extends State<AuthHedar> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
 
  @override
  Widget build(BuildContext context) {
    // User? user = _auth.currentUser;
    // return user == null ? Router_all() : Home();
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        // initialRoute: '/',
        routes: {
          // '/':(context)=>  Home(),
          '/myAccount': (context) => MyAccount(),
          '/home': (context) => Home(),
          '/register_user': (context) => Register(),
          '/login': (context) => Login_system(),
          '/orders': (context) => Card_show(),
          '/about': (context) => About(),
          '/category': (context) => Category_show(),
          '/edit': (context) => AddProdect(),
          '/favorite': (context) => MyFavotite(),
          '/detail': (context) => DitalePage(),
          '/edit_profile': (context) => EditProfile(),
        },
        // home: EditProfile()
       
        
         home: FutureBuilder(
          future: whichHomePage(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            if (snapshot.data == 'no_user') {
              //TODO: return login page
                  return Login_system();
            } else if (snapshot.data == 'admin') {
              //TODO: return admin screen
              return Category_show();
            } else {
              //TODO: return user screen
              return Home();
            }
          },
        )
        );
             
  }
    whichHomePage() async {
    if (_auth.currentUser == null) {
      return 'no_user';
    } else {
      var user = await FirebaseFirestore.instance
          .collection('admin')
          .doc(_auth.currentUser!.uid)
          .get();
      if (user.exists) {
        return 'admin';
      } else {
        return 'user';
      }
    }
  }
}

