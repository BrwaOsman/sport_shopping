class FavoriteModel {
 String ?name;
  String ?image;
  String ?category;
  List?size;
  List ?color;
  int ?price;


  FavoriteModel({this.name, this.image, this.category, this.size, this.color, this.price});

  FavoriteModel.fromMap( json) {
    name = json['name'];
    image = json['image'];
    category = json['category'];
    size = json['size'];
    color = json['color'];
    price = json['price'];
    
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'category': category,
      'size': size,
      'color': color,
      'price': price,
     
    };
  }

}