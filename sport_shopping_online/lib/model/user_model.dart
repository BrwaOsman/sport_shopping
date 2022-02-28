// import 'package:flutter/cupertino.dart';

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  String ?user_name;
  String ?user_email;
  String ?user_password;
  String ?user_phone;
  String ?user_address;
  String ?user_city;

  UserModel(
      {
      this.user_name,
      this.user_email,
      this.user_password,
      this.user_phone,
      this.user_address,
      this.user_city,
      

      });

  factory UserModel.fromMap(map) {
    return UserModel(
      user_name: map['user_name'],
      user_email: map['user_email'],
      user_password: map['user_password'],
      user_phone: map['user_phone'],
      user_address: map['user_address'],
      user_city: map['user_city'],


    );
  }
  Map<String, dynamic> toMap() {
    return {
      'user_name': user_name,
      'user_email': user_email,
      'user_password': user_password,
      'user_phone': user_phone,
      'user_address': user_address,
      'user_city': user_city,
    };
  }
}
