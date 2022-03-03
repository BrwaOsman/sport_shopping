// import 'dart:html';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sport_shopping_online/model/Crad_model.dart';
import 'package:sport_shopping_online/page/Card_show.dart';
// import 'package:google_fonts/google_fonts.dart';

class DitalePage extends StatefulWidget {
  final String? image1;
  final String? title;
  final int? number;
  final List? color;
  final String? primary;
  final List? size;
  final String? description;
  final String? category;
  const DitalePage(
      {Key? key,
      this.image1,
      this.title,
      this.number,
      this.color,
      this.size,
      this.description,
      this.category,
      this.primary})
      : super(key: key);

  @override
  _DitalePageState createState() => _DitalePageState();
}

class _DitalePageState extends State<DitalePage> {
  Color? otherColor;
  Color? otherColor2;
  String? otherColorString;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // FirebaseAuth _auth = ;
  bool isFavorite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String typeColors = widget.primary!;
    String valueString =
        typeColors.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    otherColor = new Color(value);
    print(widget.color);
    setState(() {});
  }

  List<bool> isSelectedList = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,

      appBar: AppBar(
        title: Text(
          'DitalePage',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                print('clicked');
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF817B7B),
                size: 35,
              ),
            ),
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[500],

      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 1.35),
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-0.86, -0.57),
                      child: Text(
                        'Color',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [

                    // ColorBag(
                    //   color: Color(0xFF445B81),
                    // ),
                    // ColorBag(
                    //   color: Color(0xFF8D8787),
                    // ),
                    // ColorBag(
                    //   color: Color(0xFFDC8058),
                    // ),
                    // showColorAll(widget.color!),
                    SizedBox(
                      // height: 20,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.color!.length,
                          itemBuilder: (context, index) {
                            if (widget.color![index] == "null") {
                              return Container(
                                  width: 20, height: 20, child: Text(""));
                            } else {
                              String typeColors = "${widget.color![index]}";
                              String valueString = typeColors
                                  .split('(0x')[1]
                                  .split(')')[0]; // kind of hacky..
                              int value = int.parse(valueString, radix: 16);
                              otherColor2 = new Color(value);
                              print(otherColor2);
                              return Align(
                                alignment: Alignment(-0.50, -0.43),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Colors_show(otherColor2!, () {
                                    setState(() {
                                      isSelectedList[index] =
                                          !isSelectedList[index];
                                    });
                                    if (isSelectedList[index] == true) {
                                      otherColorString = widget.color![index];
                                    }
                                  }, index),
                                ),
                              );
                            }
                          }),
                    ),

                    //   ],
                    // ),
                    // Align(
                    Align(
                        alignment: Alignment(0.43, -0.56),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Size\n',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: '12 cm'),
                              ]),
                        )),
                    Align(
                      alignment: Alignment(-0.52, 0.01),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Text(
                          '${widget.description}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Amount(),
                    Align(
                      alignment: Alignment(0.8, 0.4),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color:isFavorite? Colors.white:Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                           
                          },
                         icon: Icon(
                            Icons.favorite_sharp,
                          color: isFavorite == false?Colors.white : Colors.red,
                          size: 30,
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.91, 0.8),
                        child: SizedBox(
                            width: 70,
                            height: 60,
                            child: OutlineButton(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              onPressed: () async {
                                print('clicked');
                                await add_card().then((value) {
                                  Navigator.pushNamed(context, '/orders');
                                });
                              },
                              child: Icon(Icons.shopping_cart_outlined),
                            ))),
                    Align(
                      alignment: Alignment(0.6, 0.8),
                      child: SizedBox(
                          width: 250,
                          height: 60,
                          child: FlatButton(
                            child: Text(
                              'BUY NOW',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFFF8F0F0),
                              ),
                            ),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {/** */},
                          )),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.89, -0.95),
              child: Text(
                'Aristocratic ${widget.category}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFFF8F0F0),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.87, -0.88),
              child: Text(
                widget.title!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFFF8F0F0),
                  fontSize: 30,
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.67, -0.58),
              child: Text(
                'Price',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFFF8F0F0),
                  fontSize: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.64, -0.49),
              child: Text(
                '\$${widget.number}, 000',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFFF8F0F0),
                  fontSize: 30,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.79, -0.58),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60 / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF445B81),
                      blurRadius: 30.0,
                      offset: Offset(10, 10),
                    ),
                  ],
                  color: Color(0xFF445B81),
                  // shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  child: Image.network(
                    widget.image1!,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(60 / 2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell Colors_show(Color color, Function onTap, int index) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(2.5),
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          // color: Color(0xFF445B81),
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelectedList[index] == false ? color : Colors.black,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  // return Align(

  showColorAll(
    List listColor,
  ) {
    for (var i = 1; i < listColor.length; i++) {
      String typeColors = listColor[i];

      String valueString =
          typeColors.split('(0x')[1].split(')')[0]; // kind of hacky..
      int value = int.parse(valueString, radix: 16);
      Color Color_selct = new Color(value);

      if (listColor[i] != null) {
        // return Colors_show(Color_selct);
      } else {
        return print(listColor[i]);
      }
    }
  }

  Future add_card() async {
    if (FirebaseAuth.instance.currentUser == null) {
      debugPrint("auth is null");
    }
    debugPrint("${FirebaseAuth.instance.currentUser!.uid}");
    // User? user = _auth.currentUser;
    Amount amount = Amount();
    _AmountState amountState = amount.createState();
    CardModel cardModel = CardModel(
      name: widget.title,
      price: widget.number,
      image: widget.image1,
      quantity: amountState.number,
      category: widget.category,
      color: otherColorString == null ? 'black' : otherColorString,
      size: 'M',
    
    );
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('card')
        .doc()
        .set(cardModel.toMap());
    // .add(cardModel.toMap());
  }
}

class Amount extends StatefulWidget {
  const Amount({
    Key? key,
  }) : super(key: key);

  @override
  _AmountState createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.28, 0.4),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            height: 40,
            width: 32,
            child: OutlineButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              onPressed: () {
                setState(() {
                  if (number > 1) {
                    number--;
                  }
                });
              },
              child: Icon(Icons.remove),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              number.toString().padLeft(2, "0"),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 32,
            child: OutlineButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              onPressed: () {
                setState(() {
                  number++;
                });
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

// class ColorBag extends StatelessWidget {
//   final Color? color;
//   final int? x;
//   final int? y;
//   final bool isSelect;
//   const ColorBag({
//     Key? key,
//     this.color,
//     this.x,
//     this.y,
//     this.isSelect = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment(-0.86, -0.43),
//       child: Container(
//         padding: EdgeInsets.all(2.5),
//         width: 24,
//         height: 24,
//         decoration: BoxDecoration(
//           // color: Color(0xFF445B81),
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: isSelect ? color! : Colors.transparent,
//           ),
//         ),
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//           ),
//         ),
//       ),
//     );
//   }

//   // color
//   showColor(
//     List<Color> listColor,
//   ) {
//     for (var i = 0; i < listColor.length; i++) {
//       return ColorBag(
//         color: listColor[i],
      
//       );
//     }
//   }
// }
