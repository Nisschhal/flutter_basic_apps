import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/models/product.dart';
import 'package:shop_me/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static final routeName = '/edit-product';

  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  // final _imageController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();

  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocus.addListener(_updateImageBox);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlFocus.removeListener(_updateImageBox);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final id = ModalRoute.of(context)?.settings.arguments as String?;
      if (id != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .getproductById(id);
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// update the state of the screen if there is not focus on image url field
  void _updateImageBox() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

// save the form state when submitted
  Future<void> _saveForm() async {
    try {
      final isValid = await _form.currentState!.validate();
      if (!isValid) {
        return;
      }
      print('left');

      // save the form current state in FormState.
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      if (_editedProduct.id != '') {
        Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
        setState(() {
          _isLoading = false;
        });
      } else {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      }
    } catch (err) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occured!'),
          content: Text('Something went wrong!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save)),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues["title"],
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                      textInputAction: TextInputAction
                          .next, // show move to next input when done in keyboard
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value!,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide a title!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues["price"],
                      decoration: const InputDecoration(
                        labelText: "Price",
                      ),
                      textInputAction: TextInputAction
                          .next, // show move to next input when done in keyboard
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value!),
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide a valid Price!";
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid number!';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter number greater than 0';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues["description"],
                      decoration: const InputDecoration(
                        label: Text("Description"),
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: value!,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide a Description!";
                        }
                        if (value.length < 10) {
                          return "Please enter description of more than 10 characters!";
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 10),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text("Enter a URL")
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: _initValues["imageUrl"],
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value!,
                                  isFavorite: _editedProduct.isFavorite);
                            },
                            onFieldSubmitted: (_) => _saveForm(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please provide a valid image Url!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_me/providers/products_provider.dart';

// import '../models/product.dart';

// class EditProductScreen extends StatefulWidget {
//   static const routeName = '/edit-product';

//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   final _priceFocusNode = FocusNode();
//   final _descriptionFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _editedProduct = Product(
//     id: '',
//     title: '',
//     price: 0,
//     description: '',
//     imageUrl: '',
//   );
//   var _initValues = {
//     'title': '',
//     'description': '',
//     'price': '',
//     'imageUrl': '',
//   };
//   var _isInit = true;

//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final productId = ModalRoute.of(context)?.settings.arguments as String?;
//       if (productId != null) {
//         _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
//             .getproductById(productId);
//         _initValues = {
//           'title': _editedProduct.title,
//           'description': _editedProduct.description,
//           'price': _editedProduct.price.toString(),
//           // 'imageUrl': _editedProduct.imageUrl,
//           'imageUrl': '',
//         };
//         _imageUrlController.text = _editedProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _priceFocusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }

//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       if ((!_imageUrlController.text.startsWith('http') &&
//               !_imageUrlController.text.startsWith('https')) ||
//           (!_imageUrlController.text.endsWith('.png') &&
//               !_imageUrlController.text.endsWith('.jpg') &&
//               !_imageUrlController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }

//   void _saveForm() {
//     final isValid = _form.currentState?.validate();
//     if (!isValid!) {
//       return;
//     }
//     _form.currentState?.save();
//     if (_editedProduct.id != null) {
//       Provider.of<ProductsProvider>(context, listen: false)
//           .updateProduct(_editedProduct.id, _editedProduct);
//     } else {
//       Provider.of<ProductsProvider>(context, listen: false)
//           .addProduct(_editedProduct);
//     }
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Product'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _saveForm,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _form,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 initialValue: _initValues['title'],
//                 decoration: InputDecoration(labelText: 'Title'),
//                 textInputAction: TextInputAction.next,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_priceFocusNode);
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please provide a value.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _editedProduct = Product(
//                       title: value!,
//                       price: _editedProduct.price,
//                       description: _editedProduct.description,
//                       imageUrl: _editedProduct.imageUrl,
//                       id: _editedProduct.id,
//                       isFavorite: _editedProduct.isFavorite);
//                 },
//               ),
//               TextFormField(
//                 initialValue: _initValues['price'],
//                 decoration: InputDecoration(labelText: 'Price'),
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.number,
//                 focusNode: _priceFocusNode,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_descriptionFocusNode);
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a price.';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number.';
//                   }
//                   if (double.parse(value) <= 0) {
//                     return 'Please enter a number greater than zero.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _editedProduct = Product(
//                       title: _editedProduct.title,
//                       price: double.parse(value!),
//                       description: _editedProduct.description,
//                       imageUrl: _editedProduct.imageUrl,
//                       id: _editedProduct.id,
//                       isFavorite: _editedProduct.isFavorite);
//                 },
//               ),
//               TextFormField(
//                 initialValue: _initValues['description'],
//                 decoration: InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//                 keyboardType: TextInputType.multiline,
//                 focusNode: _descriptionFocusNode,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description.';
//                   }
//                   if (value.length < 10) {
//                     return 'Should be at least 10 characters long.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _editedProduct = Product(
//                     title: _editedProduct.title,
//                     price: _editedProduct.price,
//                     description: value!,
//                     imageUrl: _editedProduct.imageUrl,
//                     id: _editedProduct.id,
//                     isFavorite: _editedProduct.isFavorite,
//                   );
//                 },
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     width: 100,
//                     height: 100,
//                     margin: EdgeInsets.only(
//                       top: 8,
//                       right: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 1,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     child: _imageUrlController.text.isEmpty
//                         ? Text('Enter a URL')
//                         : FittedBox(
//                             child: Image.network(
//                               _imageUrlController.text,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(labelText: 'Image URL'),
//                       keyboardType: TextInputType.url,
//                       textInputAction: TextInputAction.done,
//                       controller: _imageUrlController,
//                       focusNode: _imageUrlFocusNode,
//                       onFieldSubmitted: (_) {
//                         _saveForm();
//                       },
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter an image URL.';
//                         }
//                         if (!value.startsWith('http') &&
//                             !value.startsWith('https')) {
//                           return 'Please enter a valid URL.';
//                         }
//                         if (!value.endsWith('.png') &&
//                             !value.endsWith('.jpg') &&
//                             !value.endsWith('.jpeg')) {
//                           return 'Please enter a valid image URL.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _editedProduct = Product(
//                           title: _editedProduct.title,
//                           price: _editedProduct.price,
//                           description: _editedProduct.description,
//                           imageUrl: value!,
//                           id: _editedProduct.id,
//                           isFavorite: _editedProduct.isFavorite,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
