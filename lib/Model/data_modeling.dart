import 'dart:convert';
import 'package:http/http.dart' as http;
class Product{
  final id;
  final title;
  final price;
  final description;
  final category;
  final image;
  Rating rate;
  
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
  });

  factory Product.fromjson(Map<String,dynamic> json){
    return Product(
      id: json['id'], 
      title: json['title'], 
      price: json['price'], 
      description: json['description'], 
      category: json['categoty'], 
      image: json['image'],
      rate: json['rating']['rate'],
    );
  }
}
Future<List<Product>> fectData() async{
  final responce = await http.get(Uri.parse("https://fakestoreapi.com/products"));
  switch(responce.statusCode){
    // ignore: constant_pattern_never_matches_value_type
    case 200 :
    {
      final products = jsonDecode(responce.body) as List;
      final lstProduct = products.map((e) {
        final rate = Rating(
          rate: e['rating']['rate'], 
          count: e['rating']['count'],
        );
        return Product(
          id: e['id'],
          title: e['title'], 
          price: e['price'],
          description: e['description'], 
          category: e['category'],
          image: e['image'],
          rate: rate,
        );
      }).toList();
      return lstProduct;
    }
    default :{
      throw Exception('Fails to load data');
    }
  }
}
class Rating{
  final rate;
  final count;
  Rating({
    required this.rate,
    required this.count,
  });
}