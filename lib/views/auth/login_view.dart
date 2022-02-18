import 'package:flutter/material.dart';
import 'package:kohisong/views/auth/signup_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

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
                Image(image: AssetImage('assets/logo.png'), height: 100),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgeet password?'),
                    TextButton(onPressed: () {}, child: Text('Reset')),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text('Login'),
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 36),
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpView()));
                        },
                        child: Text('Register')),
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
