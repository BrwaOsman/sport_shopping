// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sport_shopping_online/Router/drawer.dart';
import 'package:sport_shopping_online/model/prodect_model.dart';
import 'package:sport_shopping_online/page/category.dart';
import 'package:sport_shopping_online/server/firStorage.dart';

import 'DitalePage.dart';

class Home extends StatefulWidget {
final int? id;
  const Home({Key? key ,this.id }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin {
  FireStor _fireStor = FireStor();
  ScrollController _scrollController = new ScrollController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  bool _isSearch = false;

TabController ? _tabController;


 void initState() {
    super.initState();
    // 创建Controller  
    _tabController = TabController(vsync: this ,length: 5 );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            bottom: TabBar(
              controller: _tabController,
              labelColor: Color(0xFF120B0B),
              unselectedLabelColor: Color(0xFF8D8787),
              indicatorColor: Color(0xFF120B0B),
              // isScrollable: true,
              tabs: [
                Tab(text: "dress"),
                Tab(text: "shoes"),
                Tab(text: "ball"),
                Tab(text: "bags"),
                Tab(text: "socke"),
              ],
            ),
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
      drawer:MyDrawer(),

      floatingActionButton:widget.id == 1? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Category_show()),
          );
        
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF120B0B),
      ): null,
      backgroundColor: Color(0xFFE7E1E1),
      body: Padding(
        padding: const EdgeInsets.only( top:20.0),
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
            if(_isSearch == true)
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: TextField(
                decoration: InputDecoration(
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
                  print(value);
                },
              ),
            ),
    

            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('products').where('category',isEqualTo: category_test).snapshots(),
              //  stream: _fireStor.getDataUser(null),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  List<DocumentSnapshot> _docs = snapshot.data!.docs;
                  if (_scrollController.hasClients) {
                    _scrollController
                        .jumpTo(_scrollController.position.minScrollExtent);
                  }
                  List<Product> _product =
                      _docs.map((doc) => Product.fromMap(doc.data())).toList();
                   if (_product.length == 0) {
                    return Center(
                     child: Lottie.asset("assets/Lottie/empty.json", width: 600, height: 200)
                    );
                     
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
                            return show_prodect(context, _product, index);
                          })
                      );
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

  InkWell show_prodect(
      BuildContext context, List<Product> _product, int index) {
    String typeColors = _product[index].color!;
    String valueString =
        typeColors.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DitalePage(
                    image1: _product[index].image,
                    title: _product[index].name,
                    number: _product[index].price,
                    primary: _product[index].color as String,
                    color: _product[index].colors,
                    size: _product[index].sizes,
                    description: _product[index].description,
                    category: _product[index].category,
                  ))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              width: 130,
              height: 140,
              decoration: BoxDecoration(
                color: otherColor, //Color(0xFFE7E1E1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    _product[index].image!,
                    width: 10,
                    height: 10,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              _product[index].name!,
              // textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              '\$ ${_product[index].price}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
