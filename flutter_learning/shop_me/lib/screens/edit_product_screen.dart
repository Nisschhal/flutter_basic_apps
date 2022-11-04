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
    super.didChangeDependencies();
    if (_isInit) {
      final id = ModalRoute.of(context)?.settings.arguments;
      if (id != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .getproductById(id.toString());
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
  }

// update the state of the screen if there is not focus on image url field
  void _updateImageBox() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

// save the form state when submitted
  void _saveForm() {
    final isFormValid =
        _form.currentState?.validate(); // validates the input field
    if (!isFormValid!) {
      return;
    }
    _form.currentState?.save(); // save all the form input fields sate

    if (_editedProduct.id == '') {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      final productsData = Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct);
    }
    Navigator.of(context).pop(); // pop the screen
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Product added Successfully!!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(onPressed: () => _saveForm(), icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues["title"],
                decoration: InputDecoration(
                  label: Text("Title"),
                ),
                textInputAction: TextInputAction
                    .next, // show move to next input when done in keyboard
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value!,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
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
                decoration: InputDecoration(
                  label: Text("Price"),
                ),
                textInputAction: TextInputAction
                    .next, // show move to next input when done in keyboard
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl);
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
                decoration: InputDecoration(
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
                      imageUrl: _editedProduct.imageUrl);
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
                      initialValue: _imageUrlController.text,
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value!);
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
