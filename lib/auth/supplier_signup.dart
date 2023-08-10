import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../widgets/auth_widgets.dart';
import '../widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class SupplierRegister extends StatefulWidget {
  const SupplierRegister({Key? key}) : super(key: key);

  @override
  _SupplierRegisterState createState() => _SupplierRegisterState();
}

class _SupplierRegisterState extends State<SupplierRegister> {
  late String storeName;
  late String storeLogo;
  late String email;
  late String password;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  dynamic _pickedImageError;
  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signup() async {
    setState(() {
      processing = true;
    });

    if (_formkey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('cust-images/$email.jpg');

          await ref.putFile(File(_imageFile!.path));
          _uid = FirebaseAuth.instance.currentUser!.uid;
          storeLogo = await ref.getDownloadURL();
          suppliers.doc(_uid).set({
            'storename': storeName,
            'email': email,
            'storelogo': storeLogo,
            'phone': '',
            'sid': _uid,
          });
          _formkey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });
          Navigator.pushReplacementNamed(context, '/supplier_login');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            MyMessageHandler.showSnackBar(_scaffoldkey, 'Password is too weak');
          } else if (e.code == 'email-already-in-use') {
            MyMessageHandler.showSnackBar(_scaffoldkey, 'Email already exists');
            setState(() {
              processing = false;
            });
          }
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(
            _scaffoldkey, 'please pick an image first');
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthHeaderLabel(
                        headerLabel: 'Sign Up',
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                          15,
                                        ),
                                        topRight: Radius.circular(15))),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                          15,
                                        ),
                                        bottomRight: Radius.circular(15))),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.photo,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            storeName = value;
                          },
                          // controller: _namecontroller,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Enter your full name';
                            }
                            return null;
                          }),
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Full Name',
                              hintText: 'Enter your full name'),
                        ),
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
                      HaveAccount(
                        haveAccount: 'already have account?',
                        actionLabel: 'Login',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/supplier_login');
                        },
                      ),
                      processing == true
                          ? CircularProgressIndicator()
                          : AuthMainButton(
                              mainButtonLabel: 'Sign up',
                              onPressed: () {
                                signup();
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
