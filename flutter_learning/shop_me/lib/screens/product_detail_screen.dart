import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_me/models/product.dart';
import 'package:shop_me/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const routeName = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final id = args['id'] as String;
    // final title = args['title'] as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .getproductById(
            id); // doesn't change the UI if state in ProductsProvider changes
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Center(child: Text(loadedProduct.id)),
    );
  }
}
