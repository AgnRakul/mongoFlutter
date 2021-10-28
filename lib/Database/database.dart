import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodbflutter/Models/product.dart';
import 'package:mongodbflutter/utils/constants.dart';

class MongoDatabase {
  // ignore: prefer_typing_uninitialized_variables
  static var db, userCollection;

  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    userCollection = db.collection(usercollection);
  }

  static Future getDocuments() async {
    try {
      final product = await userCollection.find().toList();
      return product;
    } catch (e) {
      return Future.value(e);
    }
  }

  static insert(Product product) async {
    await userCollection.insertAll([product.toMap()]);
  }

  static update(Product product) async {
    var data = await userCollection.findOne({"_id": product.id});
    data["name"] = product.fruitName;
    data["details"] = product.fruitDetials;
    data["prize"] = product.prize;
    await userCollection.save(data);
  }

  static delete(Product product) async {
    await userCollection.remove(where.id(product.id));
  }
}
