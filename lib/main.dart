import 'package:flutter/material.dart';
import 'package:mongodbflutter/Database/database.dart';
// import 'package:mongodbflutter/Pages/add_product.dart';
import 'package:mongodbflutter/Pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      // ),
    );
  }
}
