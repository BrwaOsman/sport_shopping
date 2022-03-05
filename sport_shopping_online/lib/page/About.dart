// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sport_shopping_online/Router/drawer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class About extends StatefulWidget {
  const About({ Key? key }) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.black, fontSize: 20.0,fontFamily:'Nisebuschgardens' ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),drawer: MyDrawer(0),
      body: Column(
        children: [
          Container(
            width:200,
            height: 200,
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/img/about.jpg'),
                // fit: BoxFit.cover,
              ),
            ),
            // child: Image.network('',
            // width: 250, height: 250,),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: Text('Brwa Osman', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            child: Text('Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum',
             style: TextStyle(fontSize: 16, color: Colors.grey[700] , fontFamily: 'assets/font/About.ttf'  ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Icon(Icons.person, color: Colors.black,),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text('contact info', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
              ),
            ],
       
          ),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50,),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(Icons.phone, color: Colors.grey[700],),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text('+966 544 544 544', style: TextStyle(fontSize: 16, color: Colors.grey[700] ),),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50,),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(Icons.email, color: Colors.grey[700],),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text('osbrwa68@gmail.com', style: TextStyle(fontSize: 16, color: Colors.grey[700] ),),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child:Text('Check me out on social media:', style: TextStyle(fontSize: 16, color: Colors.black ),),
            ) ,
          Container(
            margin: EdgeInsets.only(left: 50, right: 50,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(Feather.facebook, color: Colors.black,),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(Feather.twitter, color: Colors.black,),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(Feather.instagram, color: Colors.black,),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(Feather.youtube, color: Colors.black,),
                ),
               
              ],
            ),
          ),
          //  Container(
          //   margin: EdgeInsets.all(15),
          //   child:Text('@ 2022 Copy Write Brwa Osman ', style: TextStyle(fontSize: 16, color: Colors.grey[700] ),),
          //  ),
            
        ],
      )
    );
      

  }
}