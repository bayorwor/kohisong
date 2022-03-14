import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Product'),
      ),
      body: Center(
        child: Text('Search Product'),
      ),
    );
  }
}
