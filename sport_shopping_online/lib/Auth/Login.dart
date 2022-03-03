// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sport_shopping_online/page/Home.dart';

class Login_system extends StatefulWidget {
  const Login_system({Key? key}) : super(key: key);

  @override
  _Login_systemState createState() => _Login_systemState();
}

class _Login_systemState extends State<Login_system>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  User? theUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Login_Admin'),
            Tab(text: 'Login_User'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Login_admin(),
          Login_user(),
        ],
      ),
    );
  }

  Login_admin() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: ListView(
          children: [
            Center(
              child: Text(
                'Login_Admin',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
                child: Lottie.asset("assets/Lottie/login_admin.json",
                    width: 600, height: 200)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                send_login_admin();
              },
            ),
          ],
        ),
      ),
    );
  }

  Login_user() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: ListView(
          children: [
            Center(
              child: Text(
                'Login_User',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
                child: Lottie.asset("assets/Lottie/login_user.json",
                    width: 600, height: 200)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _userEmailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _userPasswordController,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                send_login_user();
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register_user');
                },
                child: Text(
                  'Add new user',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }

  send_login_user() async {
    // login_user
    await _auth.signInWithEmailAndPassword(
        email: _userEmailController.text,
        password: _userPasswordController.text);

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) async{
      if (!value.exists) {
        print('user not found');
          AlertDialog alertDialog = AlertDialog(
        title: Text('Error'),
        content: Text('user not found *',style: TextStyle(fontSize: 20,color:Colors.red ),),
      );
      showDialog(context: context, builder: (_) => alertDialog);
            await FirebaseAuth.instance.signOut();
          setTheUser(null);
      } else {
        print('user found');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      id: 0,
                    )));
      }
    });
  }

  void setTheUser(User? user) {
    theUser = user;
  }

  Future send_login_admin() async {
    // login_admin
    try {
      UserCredential login = await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      await _firestore
          .collection('admin')
          .doc(login.user!.uid)
          .get()
          .then((value) async {
        if (!value.exists)  {
          print('admin not found');
           AlertDialog alertDialog = AlertDialog(
        title: Text('Error'),
        content: Text('Admin not found *',style: TextStyle(fontSize: 20,color:Colors.red ),),
      );
      showDialog(context: context, builder: (_) => alertDialog);
            await FirebaseAuth.instance.signOut();
          setTheUser(null);
        } else {
          print('admin found');
          return Navigator.pushNamed(context, '/category');
        }
      });
    } on PlatformException catch (e) {
      print(e);
      AlertDialog alertDialog = AlertDialog(
        title: Text('Error'),
        content: Text(e.message!),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}
