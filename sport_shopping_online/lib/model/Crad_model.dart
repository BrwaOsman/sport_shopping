// import 'package:flutter/cupertino.dart';

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CardModel {

  String ?name;
  String ?image;
  String ?category;
  String ?size;
  String ?color;
  int ?price;
  int? quantity;


  CardModel(
      {
    
      this.name,
      this.image,
      this.category,
      this.price,
      this.size,
      this.color,
      this.quantity,
      });

  factory CardModel.fromMap(map) {
    return CardModel(
     name: map['name'],
      image: map['image'],
      category: map['category'],
      price: map['price'],
      quantity: map['quantity'],
      size: map['size'],
      color: map['color'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'category': category,
      'price': price,
      'size': size,
      'color': color,
      'quantity': quantity,
    };
  }
}
