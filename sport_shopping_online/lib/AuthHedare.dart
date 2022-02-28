// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/Auth/Login.dart';
import 'package:sport_shopping_online/Auth/Register.dart';
import 'package:sport_shopping_online/Router/Router.dart';
import 'package:sport_shopping_online/page/Card_show.dart';
import 'package:sport_shopping_online/page/DitalePage.dart';
import 'package:sport_shopping_online/page/Home.dart';
import 'package:sport_shopping_online/page/category.dart';
import 'package:sport_shopping_online/page/myAccount.dart';

import 'page/AddProdect.dart';

class AuthHedar extends StatefulWidget {
  const AuthHedar({Key? key}) : super(key: key);

  @override
  _AuthHedarState createState() => _AuthHedarState();
}

class _AuthHedarState extends State<AuthHedar> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // User? user = _auth.currentUser;
    // return user == null ? Router_all() : Home();
  return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    // initialRoute: '/',
    routes:{
      // '/':(context)=>  Home(),
      '/myAccount':(context)=>MyAccount(),
      '/home':(context)=>Home(),
      '/register_user':(context)=>Register(),
      '/login':(context)=>Login_system(),
      '/orders':(context)=>Card_show(),
      '/category':(context)=>Category_show(),
      '/edit':(context)=>AddProdect(),
      '/detail':(context)=>DitalePage(),
    },
    home: _auth.currentUser == null ? Login_system() : Home()
      
    );
  }
}
