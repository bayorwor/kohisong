import 'package:flutter/material.dart';
import 'package:kohisong/resources/auth_methods.dart';
import 'package:kohisong/views/auth/login_view.dart';
import 'package:kohisong/widgets/toastwidget.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  //sign in user
  resetUser() {
    setState(() {
      _isLoading = true;
    });

    AuthMethods().resetPassword(email: _emailController.text).then((value) {
      if (value == "success") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Please confirm your email"),
                content: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                actions: [
                  TextButton(
                    child: const Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                  )
                ],
              );
            });
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
                TextButton(
                    onPressed: () {
                      resetUser();
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          )
                        : const Text('Reseet Password'),
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 36),
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Can remember password?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: const Text('Sign in')),
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
