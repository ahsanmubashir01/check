import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_apps/auth/customer_signup.dart';
import 'package:multi_store_apps/auth/supplier_login.dart';
import 'package:multi_store_apps/auth/supplier_signup.dart';

import 'package:multi_store_apps/main_screens/supplier_home.dart';
import 'package:multi_store_apps/main_screens/upload_product.dart';

import 'auth/customer_login.dart';
import 'main_screens/customer_home.dart';
import 'main_screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: WelcomeScreen(),
      initialRoute: '/welcome_screen',
      routes: {
        '/upload_product':(context) =>UploadProductScreen(),
        '/welcome_screen':(context) =>WelcomeScreen(),
        '/customer_home':(context) =>CustomerHomeScreen(),
        '/supplier_home':(context) =>SupplierHomeScreen(),
        '/customer_signup':(context) =>CustomerRegister(),
        '/customer_login':(context) =>CustomerLogin(),

        '/supplier_signup':(context) =>SupplierRegister(),
        '/supplier_login':(context) =>SupplierLogin(),

      },

    );
  }
}
