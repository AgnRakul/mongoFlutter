import 'package:mongo_dart/mongo_dart.dart';

class Product {
  late final ObjectId id;
  late final String fruitName;
  late final String fruitDetials;
  late final int prize;

  Product(
      {required this.id,
      required this.fruitName,
      required this.fruitDetials,
      required this.prize});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': fruitName,
      'details': fruitDetials,
      'prize': prize,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : fruitName = map['name'],
        id = map['_id'],
        fruitDetials = map['details'],
        prize = map['prize'];
}
