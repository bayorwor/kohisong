import 'package:flutter/material.dart';
import 'package:kohisong/resources/auth_methods.dart';
import 'package:kohisong/views/auth/forget_password_view.dart';
import 'package:kohisong/views/auth/signup_view.dart';
import 'package:kohisong/views/home_view.dart';
import 'package:kohisong/widgets/toastwidget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  //sign in user
  signInUser() {
    setState(() {
      _isLoading = true;
    });

    AuthMethods()
        .loginUser(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      if (value == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
            (route) => false);
        setState(() {
          _isLoading = false;
        });
        showToast("Login Successful", color: Colors.green);
      } else {
        showToast(value);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(image: AssetImage('assets/logo.png'), height: 100),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                  },
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Forgeet password?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordView()));
                        },
                        child: const Text('Reset')),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      signInUser();
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          )
                        : const Text('Login'),
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 36),
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpView()));
                        },
                        child: const Text('Register')),
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
