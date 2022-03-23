import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Container(
        height: 100,
        child: Center(
          child: Column(
            children: const [
              Text("Product not added"),
              Icon(UniconsLine.times_circle, color: Colors.red, size: 60),
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
  }
}
