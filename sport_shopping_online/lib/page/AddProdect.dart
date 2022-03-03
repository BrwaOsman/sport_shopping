// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_field, override_on_non_overriding_member, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_shopping_online/model/prodect_model.dart';
import 'package:sport_shopping_online/page/Home.dart';
import 'package:sport_shopping_online/server/firStorage.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AddProdect extends StatefulWidget {
  final String? CategoryId;
  const AddProdect({Key? key, this.CategoryId}) : super(key: key);

  @override
  _AddProdectState createState() => _AddProdectState();
}

class _AddProdectState extends State<AddProdect> {
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
  Color? _color;
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
 
// form key
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
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
      body: Form(
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
              MaterialColorPicker(
                onColorChange: (Color color) {
                  // Handle color changes
                  _color = color;
                  print(color);
                },
                selectedColor: Colors.red,
                colors: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.orange,
                ],
              ),
              if(widget.CategoryId == "dress" || widget.CategoryId == "bags" || widget.CategoryId == "shoes")
              Center(
                child: Text(
                  'Sizes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              if (widget.CategoryId == "dress" || widget.CategoryId == "bags") 
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
              if (widget.CategoryId == "shoes") 
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        ? "https://images.unsplash.com/photo-1599420186946-7b6fb4e297f0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60"
                        : _stor.ImageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    AddProdect();
                    Navigator.pushNamed(context, '/category');
                  }
                },
                child: Text('Add Product'),
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
          color: isChecked ? Colors.amber : Colors.grey,
        ),
        child: Text(
          '$show',
          style: TextStyle(fontSize: 24, color: Colors.white),
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
      category: widget.CategoryId,
      color: _color.toString(),
      colors: colors,
      sizes: sizes,
      image: _stor.ImageUrl,
    );
    await _firestore.collection('products').add(prodect_model.toMap());
  }
}
