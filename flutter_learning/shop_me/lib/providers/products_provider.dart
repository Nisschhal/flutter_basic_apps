import 'package:flutter/material.dart';
import 'package:shop_me/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get showFavProducts {
    return _products
        .where((element) => element.isFavorite)
        .toList(); // return where element.isFavorite is true
  }

  Product getproductById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  Future<void> getAndSetProducts() async {
    final url = Uri.parse(
        'https://shop-me-37394-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      extractedData.forEach(
        (productId, product) => loadedProducts.add(
          Product(
            id: productId,
            title: product['title'],
            description: product['description'],
            price: product['price'],
            imageUrl: product["imageUrl"],
            isFavorite: product['isFavorite'],
          ),
        ),
      );

      _products = loadedProducts;
      print(json.decode(response.body));
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  Future<void> addProduct(Product product) async {
    // add the .json exentsion
    final url = Uri.parse(
        'https://shop-me-37394-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _products.add(newProduct);
      print('product Saved Successfully!');
      notifyListeners(); // helps to notify, state and change the dependent widgets
    } catch (err) {
      print(err);
      throw err;
    }
  }

//   void updateProduct(String id, Product product) {
//     int _updateIndex = _products.indexWhere((element) => element.id == id);
//     _products[_updateIndex] = Product(
//         id: product.id,
//         title: product.title,
//         description: product.description,
//         price: product.price,
//         imageUrl: product.imageUrl);
//   }
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _products.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _products[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    final _deleteProduct = getproductById(id);
    _products.remove(_deleteProduct);
    notifyListeners();
  }
}
