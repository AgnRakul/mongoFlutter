import 'package:flutter/material.dart';
import 'package:mongodbflutter/Database/database.dart';
import 'package:mongodbflutter/Models/product.dart';
import 'package:mongodbflutter/Pages/add_product.dart';
import 'package:mongodbflutter/components/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.getDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Product Data'),
                ),
                body: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(
                        product: Product.fromMap(snapshot.data![index]),
                        onTapDelete: () async {
                          _deleteProduct(
                              Product.fromMap(snapshot.data![index]));
                        },
                        onTapEdit: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const AddProduct();
                              },
                              settings: RouteSettings(
                                arguments:
                                    Product.fromMap(snapshot.data![index]),
                              ),
                            ),
                          ).then((value) => setState(() {}));
                        },
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const AddProduct();
                    })).then((value) => setState(() {}));
                  },
                  child: const Icon(Icons.add),
                ),
              );
            }
          }
        });
  }

  _deleteProduct(Product product) async {
    await MongoDatabase.update(product);
    setState(() {});
  }
}
