// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'Home.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
     var getdata =  _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    getdata.then((value) {
     _emailController.text = value.data()!['user_email'];
      _nameController.text = value.data()!['user_name'];
      _phoneController.text = value.data()!['user_phone'];
      _addressController.text = value.data()!['user_address'];
      _cityController.text = value.data()!['user_city'];
      _passwordController.text = value.data()!['user_password'];
      _confirmPasswordController.text = value.data()!['user_password'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],

      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        //  automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Update Profile', style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: 'Nisebuschgardens'),),
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
              child: ElevatedButton(
                 style:ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
                child: Text('Update Profile', style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: 'Nisebuschgardens'),),
                onPressed: () {
                 Update_profile();
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
          fillColor: Colors.white, filled: true,
          labelText: '$label',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        obscureText: obscureText,
      ),
    );
  }

  Future<UserCredential> Update_profile() async {
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