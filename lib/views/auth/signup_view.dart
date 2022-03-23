import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kohisong/resources/auth_methods.dart';
import 'package:kohisong/utils/utils.dart';
import 'package:kohisong/views/auth/login_view.dart';
import 'package:kohisong/views/home_view.dart';
import 'package:kohisong/widgets/toastwidget.dart';
import 'package:unicons/unicons.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isPending = false;

  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _cardNumberController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
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
    Uint8List? im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  // register user

  registerAccount() {
    setState(() {
      isPending = true;
    });
    AuthMethods()
        .registerUser(
            name: _nameController.text,
            location: _locationController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            card: _cardNumberController.text,
            password: _passwordController.text,
            profilePic: _image!)
        .then((value) {
      if (value == "success") {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeView()), (route) => false);
      } else {
        setState(() {
          isPending = false;
        });
        showToast(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Welcome to Kohisong",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Create your account",
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Center(
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage('assets/user.jpg'),
                              ),
                        Positioned(
                            bottom: -5,
                            left: 40,
                            child: IconButton(
                              onPressed: () {
                                // selectImage();
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
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'name',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'email',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone number',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cardNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your card number";
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.credit_card),
                    labelText: 'Ghana card Number',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your location";
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    labelText: 'location',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registerAccount();
                      }
                    },
                    child: isPending
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          )
                        : const Text('Sign up'),
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 36),
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                        child: Text('Login')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
