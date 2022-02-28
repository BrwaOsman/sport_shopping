// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/Auth/Login.dart';
import 'package:sport_shopping_online/Auth/Register.dart';
import 'package:sport_shopping_online/AuthHedare.dart';
import 'package:sport_shopping_online/page/AddProdect.dart';
import 'package:sport_shopping_online/page/Card_show.dart';
import 'package:sport_shopping_online/page/DitalePage.dart';
import 'package:sport_shopping_online/page/Home.dart';
import 'package:sport_shopping_online/page/myAccount.dart';

import '../page/category.dart';

class Router_all extends StatefulWidget {
  const Router_all({ Key? key }) : super(key: key);

  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router_all> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    initialRoute: '/',
    routes:{
      '/':(context)=>AuthHedar(),
      '/myAccount':(context)=>MyAccount(),
      '/home':(context)=>Home(),
      '/register_user':(context)=>Register(),
      '/login':(context)=>Login_system(),
      '/orders':(context)=>Card_show(),
      '/category':(context)=>Category_show(),
      '/edit':(context)=>AddProdect(),
      '/detail':(context)=>DitalePage(),
    }
      
    );
  }
}