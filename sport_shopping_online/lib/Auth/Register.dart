// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/model/user_model.dart';

import '../page/Home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            textfiled('Name', _nameController, false),
            textfiled('Email', _emailController, false),
            textfiled('Phone', _phoneController, false),
            textfiled('Address', _addressController, false),
            textfiled('City', _cityController, false),
            textfiled('Password', _passwordController, true),
            textfiled('Confirm Password', _confirmPasswordController, true),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                child: Text('Register'),
                onPressed: () {
                 register_sytelm();
                  print('Register');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container textfiled(
      String label, TextEditingController controller, bool obscureText) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: '$label',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        obscureText: obscureText,
      ),
    );
  }

  Future<UserCredential> register_sytelm() async {
    UserCredential register = await _auth.createUserWithEmailAndPassword(
        email:_emailController.text , password: _passwordController.text);
    final User? user = register.user;
    if (user != null) {
      print('Register Success');
       Add_User();
    } else {
     
    }
    return register;
  }

  Future Add_User() async {
  User? user = _auth.currentUser;

    UserModel userModel = UserModel(
        user_name: _nameController.text,
        user_email: user!.email,
        user_phone: _phoneController.text,
        user_address: _addressController.text,
        user_city: _cityController.text,
        user_password: _passwordController.text);

    if (_passwordController.text == _confirmPasswordController.text) {
      await Firebase.initializeApp();
      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    id: 0,
                  )));
    } else {
      print('Password not match');
    }
  }
}
