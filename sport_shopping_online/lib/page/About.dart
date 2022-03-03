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
            width:250,
            height: 250,
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Colors.white,
              image: DecorationImage(
                image: NetworkImage('https://scontent.fisu6-2.fna.fbcdn.net/v/t39.30808-6/272182849_674226850277844_651025304481246735_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeGWz6mm0t-EHofUIW4m8f-utEL4o8szlIS0QvijyzOUhFxdiN4PtDaeaQ3ZaktwkZLXB2M2KNzepwtCXYuX52vI&_nc_ohc=VsAK9_SSBP4AX-DwPCN&tn=vatK3agCGqXVTIy1&_nc_ht=scontent.fisu6-2.fna&oh=00_AT89C7rBJDVM_e92EfBRRJBupOLqKr61cIpGiPpD5B9xzQ&oe=62226AB5'),
                fit: BoxFit.cover,
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