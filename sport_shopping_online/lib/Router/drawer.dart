// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class MyDrawer extends StatelessWidget {

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
User? user = _auth.currentUser;

    return Drawer(
     shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
        child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Image.asset('assets/img/profile.png'),
                  
                ),
                Text('${user?.email}'),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFFE7E1E1),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
   
          ListTile(
            title: Text('Category'),
            leading: Icon(Icons.category),
            onTap: () {
              Navigator.pushNamed(context, '/category');
            },
          ),
          Divider(),
          ListTile(
            title: Text('My Account'),
            leading: Icon(Icons.person),  // icon
            onTap: () {
              Navigator.pushNamed(context, '/myAccount');
            },
          ),
          Divider(),
          ListTile(
            title: Text('My Orders'),
            leading: Icon(Icons.shopping_basket),
            onTap: () {
              Navigator.pushNamed(context, '/orders');
            },
          ),
          Divider(),
          ListTile(
            title: Text('About'),
            leading: Icon(Icons.info),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              _auth.signOut();
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
  
      ));
  }
}