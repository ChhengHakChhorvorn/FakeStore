import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: 'body')
  List<Product>? product;

  ProductResponse({this.product});

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 9)
class Product {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'title')
  @HiveField(1)
  final String? title;

  @JsonKey(name: 'price')
  @HiveField(2)
  final double? price;

  @JsonKey(name: 'description')
  @HiveField(3)
  final String? description;

  @HiveField(4)
  int? qty;

  @JsonKey(name: 'category')
  @HiveField(5)
  final String? category;

  @JsonKey(name: 'image')
  @HiveField(6)
  final String? imageUrl;

  @JsonKey(name: 'rating')
  @HiveField(7)
  final Rate? rating;

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.qty,
      this.category,
      this.imageUrl,
      this.rating});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 7)
class Rate {
  @JsonKey(name: 'rate')
  @HiveField(0)
  final double? rate;
  @JsonKey(name: 'count')
  @HiveField(1)
  final int? count;

  Rate({this.rate, this.count});

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);

  Map<String, dynamic> toJson() => _$RateToJson(this);
}

Map<String, dynamic> map = {
  "id": 1,
  "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
  "price": 109.95,
  "description":
      "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
  "category": "men's clothing",
  "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
  "rating": {"rate": 3.9, "count": 120}
};
