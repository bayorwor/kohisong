import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kohisong/data_sourcess/categories.dart';
import 'package:kohisong/resources/product_methods.dart';
import 'package:kohisong/utils/utils.dart';
import 'package:unicons/unicons.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _qntyController = TextEditingController();

  String? _categoryController;
  bool isPending = false;

  Uint8List? _image;

  get onChanged => null;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    // _categoryController.dispose();
    _qntyController.dispose();
  }

  // selecting image from gallery
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

// selecting image from camera
  void selectCamera() async {
    Uint8List im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

// add new product
  addNewProduct() {
    setState(() {
      isPending = true;
    });
    ProductMethods()
        .addProduct(
      name: _nameController.text,
      price: _priceController.text,
      description: _descriptionController.text,
      category: _categoryController!,
      qnty: _qntyController.text,
      location: "Wa",
      image: _image!,
    )
        .then((value) {
      if (value == "success") {
        setState(() {
          isPending = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Success"),
                content: Container(
                  height: 100,
                  child: Center(
                    child: Column(
                      children: const [
                        Text("Product added successfully"),
                        Icon(UniconsLine.check_circle,
                            color: Colors.green, size: 60),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      // _categoryController.clear();
                      _descriptionController.clear();
                      _nameController.clear();
                      _priceController.clear();
                      _qntyController.clear();
                      setState(() {
                        _image = null;
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else {
        setState(() {
          isPending = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Container(
                  height: 100,
                  child: Center(
                    child: Column(
                      children: const [
                        Text("Product not added"),
                        Icon(UniconsLine.times_circle,
                            color: Colors.green, size: 60),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product name';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Product Name',
                ),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: DropdownButton(
                    hint: const Text('Select Category'),
                    value: _categoryController,
                    items: categories
                        .map((e) => DropdownMenuItem(
                            value: e["category"], child: Text(e["category"])))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _categoryController = value as String?;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product price';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Product Price',
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              TextFormField(
                controller: _qntyController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product quantity';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Product Quantity',
                ),
              ),
              const SizedBox(height: 16),
              const Text("Product sample image",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Select Image from",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  selectCamera();
                                },
                                icon: const Icon(
                                  UniconsLine.camera,
                                  size: 50,
                                  color: Colors.black,
                                ),
                                label: const Text("camera"),
                              ),
                              const Divider(),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  selectImage();
                                },
                                icon: const Icon(
                                  UniconsLine.image,
                                  size: 50,
                                ),
                                label: const Text("gallery"),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: _image == null
                    ? Image.asset('assets/placeholder.jpg')
                    : Image.memory(_image!, fit: BoxFit.cover, height: 200),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product description';
                  }
                },
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Product Description',
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addNewProduct();
                  }
                },
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: Colors.green),
                child: isPending
                    ? const CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      )
                    : const Text('Add Product'),
              ),
            ],
          ),
        ));
  }
}
