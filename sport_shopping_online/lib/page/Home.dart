// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, unnecessary_new, non_constant_identifier_names, avoid_print, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sport_shopping_online/Router/drawer.dart';
import 'package:sport_shopping_online/model/prodect_model.dart';
import 'package:sport_shopping_online/page/category.dart';
import 'package:sport_shopping_online/server/firStorage.dart';
import 'DitalePage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Edit_product.dart';

class Home extends StatefulWidget {
  final int? id;
  const Home({Key? key, this.id}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  FireStor _fireStor = FireStor();
  ScrollController _scrollController = new ScrollController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  bool _isSearch = false;
  String? _getdataSesrch;

  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(vsync: this, length: 5);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Color(0xFFE7E1E1),
        // automaticallyImplyLeading: false,
        title: Text(
          'Sport Shopping',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Open Sans',
            color: Color(0xFF120B0B),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        //  bottom: menu(),
        // bottom: TabBar(
        //   controller: _tabController,
        //   labelColor: Color(0xFF120B0B),
        //   unselectedLabelColor: Color(0xFF8D8787),
        //   indicatorColor: Color(0xFF120B0B),
        //   // isScrollable: true,
        //   tabs: [
        //     Tab(text: "dress"),
        //     Tab(text: "shoes"),
        //     Tab(text: "ball"),
        //     Tab(text: "bags"),
        //     Tab(text: "socke"),
        //   ],
        // ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isSearch = !_isSearch;
                });
              },
              icon: Icon(
                Icons.search_outlined,
                color: Color(0xFF817B7B),
                size: 30,
              ),
            ),
          ),
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF817B7B)),
      ),
      bottomNavigationBar: menu(),
      drawer: MyDrawer(widget.id),
      floatingActionButton: widget.id == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Category_show()),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Color(0xFF120B0B),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            get_data("dress"),
            get_data("shoes"),
            get_data("ball"),
            get_data("bags"),
            get_data("socke"),
          ],
        ),
      ),
    );
  }

  Column get_data(String category_test) {
    return Column(
      children: [
        // search_bar,
        if (_isSearch == true)
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: Colors.white, filled: true ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xFF8D8787),
                    width: 1,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF8D8787),
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontFamily: 'Open Sans',
                  color: Color(0xFF8D8787),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              onChanged: (value) {
                if (value.length < 1) {
                  setState(() {
                    _getdataSesrch = null;
                  });
                } else {
                  setState(() {
                    _getdataSesrch = value;
                    _getdataSesrch = _searchController.text;
                  });
                }
              },
            ),
          ),

        StreamBuilder<QuerySnapshot>(
          // stream: _firestore
          //     .collection('products')
          //     .where('category', isEqualTo: category_test)
          //     .snapshots(),
          stream: _fireStor.getDataUser(_getdataSesrch, category_test),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<DocumentSnapshot> _docs = snapshot.data!.docs;
              if (_scrollController.hasClients) {
                _scrollController
                    .jumpTo(_scrollController.position.minScrollExtent);
              }
              List<Product> _product =
                  _docs.map((doc) => Product.fromMap(doc.data())).toList();
              if (_product.isEmpty) {
                return Center(
                    child: Lottie.asset("assets/Lottie/empty.json",
                        width: 600, height: 200));
              } else {
                return Expanded(
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: _product.length,
                        itemBuilder: (context, index) {
                          return show_prodect(context, _product, index, _docs);
                        }));
              }
            }
            return Center(
              child: Text("Empty"),
            );
          },
        ),
      ],
    );
  }

  InkWell show_prodect(BuildContext context, List<Product> _product, int index,
      List<DocumentSnapshot> _docs) {
    return InkWell(
      onTap: () {
        print(_docs[index].id);
        if (widget.id == 1) {
          show_dialog_model(_product, index, _docs);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DitalePage(
                        id_product: _docs[index].id,
                        id: widget.id,
                        image1: _product[index].image,
                        title: _product[index].name,
                        number: _product[index].price,
                        color: _product[index].colors,
                        size: _product[index].sizes,
                        description: _product[index].description,
                        category: _product[index].category,
                      )));
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: Image.network(
                  _product[index].image!,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 120,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Text(
              _product[index].name!,
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Price: ",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  "\$ ${_product[index].price}",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  menu() {
    //     Tab(text: "dress"),
    //     Tab(text: "shoes"),
    //     Tab(text: "ball"),
    //     Tab(text: "bags"),
    //     Tab(text: "socke"),
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.black,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(
          text: "dress",
          icon: SvgPicture.asset(
            "assets/icon/tshirt.svg",
            width: 30,
          ),
        ),
        Tab(
          text: "shoes",
          icon: SvgPicture.asset(
            "assets/icon/shose.svg",
            width: 30,
          ),
        ),
        Tab(
          text: "ball",
          icon: SvgPicture.asset(
            "assets/icon/ball.svg",
            width: 30,
          ),
        ),
        Tab(
          text: "bags",
          icon: SvgPicture.asset(
            "assets/icon/bag.svg",
            width: 30,
          ),
        ),
        Tab(
          text: "socke",
          icon: SvgPicture.asset(
            "assets/icon/sock.svg",
            width: 30,
          ),
        ),
      ],
    );
  }

  show_dialog_model(List<Product> _product, int index,
      List<DocumentSnapshot> _docs) {
    AlertDialog alertDialog = AlertDialog(
        title: Text('About Model'),
        content: Container(
          // width: 300,
          height: 200,

          child: Column(
            children: [
              Text('Please Click on green button to Eidt your product.',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
              Text('Please Click on Red button to Delete your product.',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
                  SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.green,
                      child: Row(
                        children: [
                          Text('Edit',style:TextStyle(color: Colors.white) ,),
                          SizedBox(width: 10,),
                          Icon(Icons.edit,color: Colors.white,)
                        ],
                      ),
                      onPressed: () {
                         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProduct(
                        id_product: _docs[index].id,
                        id: widget.id,
                        image1: _product[index].image,
                        title: _product[index].name,
                        number: _product[index].price,
                        color: _product[index].colors,
                        size: _product[index].sizes,
                        description: _product[index].description,
                        category: _product[index].category,
                      )));
                      },
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Row(
                        children: [
                          Text('Delete',style:TextStyle(color: Colors.white) ,),
                          SizedBox(width: 10,),
                          Icon(Icons.delete,color: Colors.white,)
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Are you sure to delete this product?',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                actions: [
                                  FlatButton(
                                    color: Colors.red,
                                    child: Text('No',style: TextStyle(color: Colors.white),),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    color: Colors.green,
                                    child: Text('Yes',style: TextStyle(color: Colors.white),),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // _product[index].reference.delete();
                                    },
                                  ),
                                ],
                              );
                            });
                      
                      },
                    ),
                  ),
                ],
              ),
              RaisedButton(
                color: Colors.black,
                child: Text('cancel', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
    return showDialog(context: context, builder: (_) => alertDialog);
  }
}
