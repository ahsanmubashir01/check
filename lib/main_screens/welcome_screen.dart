import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_apps/main_screens/supplier_home.dart';
import 'package:multi_store_apps/widgets/yellow_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  late String _uid;
  bool processing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'images/inapp/bgimage.jpg',
                ),
                fit: BoxFit.cover)),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage('images/inapp/logo.jpg'),
                ),
              ),
              Text(
                'SHOP',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Suppliers only',
                        style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: AssetImage('images/inapp/logo.jpg'),
                          ),
                          YellowButton(
                              label: 'Log In',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/supplier_login');
                              },
                              width: 0.25),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: YellowButton(
                                label: 'Sign up',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/supplier_signup');
                                },
                                width: 0.25),
                          ),
                        ],
                      )),
                  Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: YellowButton(
                                label: 'Log In',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/customer_login');
                                },
                                width: 0.25),
                          ),
                          YellowButton(
                              label: 'Sign up',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/customer_signup');
                              },
                              width: 0.25),
                          Image(
                            image: AssetImage('images/inapp/logo.jpg'),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GoogleFacebookLogin(
                      label: 'Google',
                      onPressed: () {},
                      child: Image(
                        image: AssetImage('images/inapp/google.jpg'),
                      ),
                    ),
                    GoogleFacebookLogin(
                      label: 'Facebook',
                      onPressed: () {},
                      child: Image(
                        image: AssetImage('images/inapp/facebook.jpg'),
                      ),
                    ),
                    processing == true
                        ? CircularProgressIndicator()
                        : GoogleFacebookLogin(
                            label: 'Guest',
                            onPressed: () async {
                              setState(() {
                                processing = true;
                              });
                              await FirebaseAuth.instance
                                  .signInAnonymously()
                                  .whenComplete(() async {
                                    _uid = FirebaseAuth.instance.currentUser!.uid;
                                await customers.doc(_uid).set({
                                  'name': '',
                                  'email': '',
                                  'profileImage': '',
                                  'phone': '',
                                  'address': '',
                                  'cid': _uid,
                                });
                              });

                              Navigator.pushReplacementNamed(
                                  context, '/customer_home');
                            },
                            child: Icon(
                              Icons.person,
                              size: 55,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;

  const GoogleFacebookLogin({
    Key? key,
    required this.child,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
