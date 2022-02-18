import 'package:flutter/material.dart';
import 'package:kohisong/views/auth/login_view.dart';
import 'package:kohisong/views/home_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    },
                    child: Text('Sign up'),
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
