import 'package:flutter/material.dart';
import 'package:mongodbflutter/Models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      required this.product,
      required this.onTapDelete,
      required this.onTapEdit})
      : super(key: key);
  final Product product;
  final Function onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Text(
                '${product.prize}',
                style: Theme.of(context).textTheme.headline6,
              ),
              title: Text(product.fruitName),
              subtitle: Text(product.fruitDetials),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    onTapEdit;
                  },
                  child: const Text("Edit"),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    onTapDelete;
                  },
                  child: const Text("Delete"),
                ),
                const SizedBox(width: 8),
              ],
            )
          ],
        ),
      ),
    );
  }
}
