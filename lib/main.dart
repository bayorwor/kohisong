import 'package:flutter/material.dart';
import 'package:kohisong/views/auth/login_view.dart';
import 'package:kohisong/views/home_view.dart';

void main(List<String> args) {
  runApp(KohisongApp());
}

class KohisongApp extends StatelessWidget {
  const KohisongApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kohisong',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginView(),
    );
  }
}
