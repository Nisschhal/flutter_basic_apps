import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'ProductItem.dart';

class ProductGrid extends StatelessWidget {
  final showFavorite;

  const ProductGrid({
    Key? key,
    this.showFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDate = Provider.of<ProductsProvider>(context);
    final List<Product> products =
        showFavorite ? productDate.showFavProducts : productDate.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of columns in grid
          childAspectRatio:
              3 / 2, // item aspect ratio where height it lager than width
          crossAxisSpacing: 20, // spacing between columns
          mainAxisSpacing: 20), // spcing between rows
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
            // id: products[index].id,
            // title: products[index].title,
            // imageUrl: products[index].imageUrl),
            ),
      ),
    );
  }
}
