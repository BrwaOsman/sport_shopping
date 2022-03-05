// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_final_fields, override_on_non_overriding_member, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/prodect_model.dart';
import '../server/firStorage.dart';
import 'Home.dart';

class EditProduct extends StatefulWidget {
   final String? image1;
  final String? title;
  final int? number;
  final List? color;
  final String? id_product;
  final List? size;
  final String? description;
  final String? category;
  final int? id;

  const EditProduct({ Key? key ,
    this.image1,
    this.title,
    this.number,
    this.color,
    this.id_product,
    this.size,
    this.description,
    this.category,
    this.id,

  }) : super(key: key);


  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  bool Smole = false;
  bool Medium = false;
  bool Large = false;
  bool ExtraLarge = false;
  bool ExtraExtraLarge = false;
  String? _smole;
  String? _medium;
  String? _large;
  String? _extraLarge;
  String? _extraExtraLarge;

  String? _red;
  String? _green;
  String? _blue;
  String? _yellow;
  String? _orange;
  bool _redCheck = false;
  bool _greenCheck = false;
  bool _blueCheck = false;
  bool _yellowCheck = false;
  bool _orangeCheck = false;
  bool _loading = false;
  // controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  // image file
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FireStor _stor = FireStor();
  File? imageFile;
  String? ImageUrl;
  bool img = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.title!;
    _priceController.text = widget.number.toString();
    _descriptionController.text = widget.description!;
    _smole = widget.size![0];
    _smole == "null" ? Smole = false : Smole = true;
    _medium = widget.size![1];
    _medium != "null" ? Medium = true : Medium = false;
       print(_medium);
    _large = widget.size![2];
    _large == "null" ? Large = false : Large = true;
    _extraLarge = widget.size![3];
    _extraLarge == "null" ? ExtraLarge = false : ExtraLarge = true;
    _extraExtraLarge = widget.size![4];
    _extraExtraLarge == "null" ? ExtraExtraLarge = false : ExtraExtraLarge = true;
    _red = widget.color![0];
   
    _red =="null"? _redCheck = false: _redCheck = true;
    _green = widget.color![1];
    _green =="null"? _greenCheck = false: _greenCheck = true;
    _blue = widget.color![2];
    _blue =="null"? _blueCheck = false: _blueCheck = true;
    _yellow = widget.color![3];
    _yellow =="null"? _yellowCheck = false: _yellowCheck = true;
    _orange = widget.color![4];
    _orange =="null"? _orangeCheck = false: _orangeCheck = true;
 


  }
 
// form key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.grey[400] ,
      appBar: AppBar(
        backgroundColor: Colors.grey[400] ,
        title: Text('Edit Product',style: TextStyle(color: Colors.black,fontSize: 20, fontFamily: 'Nisebuschgardens'),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Home(
                  id: 1,
                );
              }));
            },
          ),
     
        ],
      ),
      body:Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormFiled(
                'Product Name *',
                _nameController,
                0,
              ),
              TextFormFiled('Product Price *', _priceController, 1),
              TextFormFiled('Product Description *', _descriptionController, 0),
             
              SizedBox(
                height: 20,
              ),
              
              if(widget.category == "dress" || widget.category == "bags" || widget.category == "shoes")
              Center(
                child: Text(
                  'Sizes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white , fontFamily: 'AquinoDemo'),
                ),
              ),
              if (widget.category == "dress" || widget.category == "bags") 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sizes(Smole, _smole, 'Smole', 'S', () {
                    setState(() {
                      Smole = !Smole;
                      _smole = 'S';
                    });
                  }),
                  sizes(Medium, _medium, 'medium', 'M', () {
                    setState(() {
                      Medium = !Medium;
                      _medium = 'M';
                    });
                  }),
                  sizes(Large, _large, 'large', 'L', () {
                    setState(() {
                      Large = !Large;
                      _large = 'L';
                    });
                  }),
                  sizes(ExtraLarge, _extraLarge, 'extraLarge', 'XL', () {
                    setState(() {
                      ExtraLarge = !ExtraLarge;
                      _extraLarge = 'XL';
                    });
                  }),
                  sizes(ExtraExtraLarge, _extraExtraLarge, 'extraExtraLarge',
                      'XXL', () {
                    setState(() {
                      ExtraExtraLarge = !ExtraExtraLarge;
                      _extraExtraLarge = 'XXL';
                    });
                  }),
                ],
              ),
              if (widget.category == "shoes") 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sizes(Smole, _smole, 'Smole', '39', () {
                    setState(() {
                      Smole = !Smole;
                      _smole = '39';
                    });
                  }),
                  sizes(Medium, _medium, 'medium', '40', () {
                    setState(() {
                      Medium = !Medium;
                      _medium = '40';
                    });
                  }),
                  sizes(Large, _large, 'large', '41', () {
                    setState(() {
                      Large = !Large;
                      _large = '41';
                    });
                  }),
                  sizes(ExtraLarge, _extraLarge, 'exlarg', '42', () {
                    setState(() {
                      ExtraLarge = !ExtraLarge;
                      _extraLarge = '42';
                    });
                  }),
                  sizes(ExtraExtraLarge, _extraExtraLarge, 'extraExtraLarge',
                      '43', () {
                    setState(() {
                      ExtraExtraLarge = !ExtraExtraLarge;
                      _extraExtraLarge = '43';
                    });
           
                 
                  }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Colors',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white , fontFamily: 'AquinoDemo') ,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  colors(_redCheck, Colors.red, () {
                    setState(() {
                      _redCheck = !_redCheck;
                      _red = Colors.red.toString();
                      print(_red);
                    });
                  }),
                  colors(_blueCheck, Colors.blue, () {
                    setState(() {
                      _blueCheck = !_blueCheck;
                      _blue = Colors.blue.toString();
                    });
                  }),
                  colors(_greenCheck, Colors.green, () {
                    setState(() {
                      _greenCheck = !_greenCheck;
                      _green = Colors.green.toString();
                    });
                  }),
                  colors(_yellowCheck, Colors.yellow, () {
                    setState(() {
                      _yellowCheck = !_yellowCheck;
                      _yellow = Colors.yellow.toString();
                    });
                  }),
                  colors(_orangeCheck, Colors.orange, () {
                    setState(() {
                      _orangeCheck = !_orangeCheck;
                      _orange = Colors.orange.toString();
                    });
                  }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Add Image',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white , fontFamily: 'AquinoDemo'),
                ),
              ),
              // Add Image Button
              InkWell(
                onTap: () {
                  _stor.getImage(imageFile);
                  if (_stor.ImageUrl != null) {
                    setState(() {
                      img = true;
                    });
                  }
                },
                child: Container(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15)),
                  child: Image.network(
                    img == false
                        ? widget.image1!
                        : _stor.ImageUrl!,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              ElevatedButton(
                 style:ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                     if (_loading) return;
                    setState(() => _loading = true);
                    await Future.delayed(Duration(seconds: 5));
                    setState(() => _loading = false);
                    AddProdect();
                    Navigator.pushNamed(context, '/category');
                  }
                },
                child:  _loading == true
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Text('Please waie ...')
                          ],
                        )
                      : Text('Update Product',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        )),
              ),
            ],
          )),
    );
  }
  InkWell sizes(bool isChecked, String? size, String? value, String? show,
      Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isChecked ? Colors.blue[400] : Colors.white,
        ),
        child: Text(
          '$show',
          style: TextStyle(fontSize: 24, color: isChecked ? Colors.white : Colors.black),
        ),
      ),
    );
  }



  Padding TextFormFiled(
      String labelText, TextEditingController controller, int x) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: x == 0 ? null : TextInputType.number,
        decoration: InputDecoration(
           fillColor: Colors.white, filled: true,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter product name';
          }
          return null;
        },
      ),
    );
  }

  InkWell colors(bool isChech, Color color, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isChech ? Colors.black : Colors.white,
          ),
          borderRadius: BorderRadius.circular(60 / 2),
          color: color,
        ),
      ),
    );
  }

  AddProdect() async {
    List<String> colors = [
      "$_red",
      "$_blue",
      "$_green",
      "$_yellow",
      "$_orange"
    ];
    List<String> sizes = [
      "$_smole",
      "$_medium",
      "$_large",
      "$_extraLarge",
      "$_extraExtraLarge"
    ];

    Product prodect_model = Product(
      name: _nameController.text,
      price: int.parse(_priceController.text),
      description: _descriptionController.text,
      category: widget.category,
      colors: colors,
      sizes: sizes,
      image: _stor.ImageUrl,

    );
    await _firestore.collection('products').doc(widget.id_product).update(prodect_model.toMap());
  }

}