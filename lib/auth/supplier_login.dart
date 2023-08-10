import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import '../widgets/snackbar.dart';

class SupplierLogin extends StatefulWidget {
  const SupplierLogin({Key? key}) : super(key: key);

  @override
  _SupplierLoginState createState() => _SupplierLoginState();
}

class _SupplierLoginState extends State<SupplierLogin> {
  late String email;
  late String password;

  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
  GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  void login() async {
    setState(() {
      processing = true;
    });

    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _formkey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/supplier_home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'no user found for that email');
        } else if (e.code == 'wrong-password') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'wrong password for that user');
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldkey, 'please fill all the fields');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.yellow,
      //     content: Text(
      //       'please fill all fiels',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //           fontSize: 18, color: Colors.black),
      //     )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldkey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      AuthHeaderLabel(
                        headerLabel: 'Log In',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          // controller: _emailcontroller,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter your  email';
                            } else if (value.isValidEmail() == false) {
                              return 'invalid email';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          }),
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Email Addrress',
                              hintText: 'Enter your email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            password = value;
                          },
                          // controller: _passwordcontroller,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter your password';
                            }
                            return null;
                          }),
                          obscureText: passwordVisible,
                          decoration: textFormDecoration.copyWith(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.purple,
                                  )),
                              labelText: 'Password',
                              hintText: 'Enter your password'),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          )),
                      HaveAccount(
                        haveAccount: 'do not  have account? ',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/supplier_signup');
                        },
                      ),
                      processing == true
                          ? CircularProgressIndicator(color: Colors.purple,)
                          : AuthMainButton(
                        mainButtonLabel: 'Log In',
                        onPressed: () {
                          login();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
