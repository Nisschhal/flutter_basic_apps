import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/models/product.dart';
import 'package:shop_me/screens/product_detail_screen.dart';

import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(
  //     {required this.id,
  //     required this.title,
  //     required this.imageUrl,
  //     super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context,
        listen: false); // doesnot rebuild widget if any changes happen in cart

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        // ignore: sort_child_properties_last
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: {"id": product.id, "title": product.title});
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_outline),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              // Scaffold.of(context).openDrawer(); // helps to connect to nearest scaffold and open drawer from there
              // ScaffoldMessenger.of(context)
              //     .hideCurrentSnackBar(); // hide the previous snackbar is there are any
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Added item to Cart!"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(
                          product.id); // when UNDO pressed then undo added cart
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
