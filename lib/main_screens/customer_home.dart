import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_apps/main_screens/Category.dart';
import 'package:multi_store_apps/main_screens/cart.dart';
import 'package:multi_store_apps/main_screens/home.dart';
import 'package:multi_store_apps/main_screens/profile.dart';
import 'package:multi_store_apps/main_screens/stores.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedindex = 0;
  final List<Widget> _tabs =  [
   HomeScreen(),
   CategoryScreen(),
    StoresScreen(),
  CartScreen(),
    ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: _selectedindex,
        items: const [
          BottomNavigationBarItem(icon: Icon
            (Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon
            (Icons.search), label: 'Category'),
          BottomNavigationBarItem
            (icon: Icon(Icons.shop), label: 'Stores'),
          BottomNavigationBarItem(
              icon: Icon
                (Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem
            (icon: Icon
            (Icons.person), label: 'Profile'),
        ],
        onTap: (index){
          setState(() {

            _selectedindex=index;

          });
        },
      ),
    );
  }
}
