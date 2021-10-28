// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:mongodbflutter/Database/database.dart';
import 'package:mongodbflutter/Models/product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detialsController = TextEditingController();
  TextEditingController prizeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    detialsController.dispose();
    prizeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product?;
    var widgetText = 'Add Product';
    if (product != null) {
      nameController.text = product.fruitName;
      detialsController.text = product.fruitDetials;
      prizeController.text = product.prize.toString();
      widgetText = 'Update Product';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widgetText),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: 'Product Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: detialsController,
                    decoration:
                        const InputDecoration(labelText: 'Product Details'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: prizeController,
                    decoration:
                        const InputDecoration(labelText: 'Product Prize'),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
              child: ElevatedButton(
                child: Text(widgetText),
                onPressed: () {
                  if (product != null) {
                    updateProduct(product);
                  } else {
                    insertProduct();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  insertProduct() async {
    final product = Product(
      id: m.ObjectId(),
      fruitName: nameController.text,
      fruitDetials: detialsController.text,
      prize: int.parse(prizeController.text),
    );
    await MongoDatabase.insert(product);
    Navigator.pop(context);
  }

  updateProduct(Product product) async {
    final p = Product(
      id: m.ObjectId(),
      fruitName: nameController.text,
      fruitDetials: detialsController.text,
      prize: int.parse(prizeController.text),
    );
    await MongoDatabase.delete(p);
    Navigator.pop(context);
  }
}
