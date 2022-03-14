import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kohisong/views/add_product.dart';
import 'package:kohisong/views/auth/login_view.dart';
import 'package:kohisong/views/dashoard.dart';
import 'package:kohisong/views/products.dart';
import 'package:kohisong/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _currentIndex = 0;

  final List<Widget> _views = [
    Dashboard(),
    AddProduct(),
    Products(),
    ProfileView(),
  ];

  @override
  initState() {
    _userAuth();
    super.initState();
  }

  _userAuth() {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginView()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _auth.currentUser == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Account',
                ),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              selectedIconTheme: const IconThemeData(size: 50),

              // showSelectedLabels: true,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            body: IndexedStack(
              index: _currentIndex,
              children: _views,
            ),
          );
  }
}
