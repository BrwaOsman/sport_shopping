// import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product {
   String ? name;
  String ? image;
  int ? price;
  String ? description;
  String ? category;
  List? sizes;
  List ? colors;
  List<String> ? images_url;

  
  Product(
      {this.name,
      this.image,
      this.price,
      this.description,
      this.category,
      this.sizes,
      this.colors,
      this.images_url,
 });

  factory Product.fromMap(map) {
    return Product(
      name: map['name'],
      image: map['image'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
      sizes: map['sizes'],
      colors: map['colors'],
      images_url: map['images_url'],

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'image' : image,
      'price' : price,
      'description' : description,
      'category' : category,
      'sizes' : sizes,
      'colors' : colors,
      'images_url' : images_url,

    };
  }
}
