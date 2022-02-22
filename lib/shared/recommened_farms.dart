import 'package:flutter/material.dart';

class RecommendFarms extends StatelessWidget {
  RecommendFarms({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 60,
        width: 100,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
