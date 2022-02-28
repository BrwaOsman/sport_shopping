// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/page/AddProdect.dart';
import 'package:sport_shopping_online/page/Home.dart';

class Category_show extends StatefulWidget {
  const Category_show({ Key? key }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category_show> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        centerTitle: true,
          actions: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home(
                id: 1,
              )));
            },
          ),
     
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            show_catygory("dress"),
            show_catygory("shoes"),
            show_catygory("bags"),
            show_catygory("ball"),
            show_catygory("Socke"),


          ],
        ),
      ),

 
      
    );
  }

  Padding show_catygory(String name) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProdect(
            CategoryId: name,
          )));
        },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:  BorderRadius.circular(20),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('$name',style: TextStyle(color: Colors.white,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
                  ],
                ),
              ),
            ),
    );
  }
}