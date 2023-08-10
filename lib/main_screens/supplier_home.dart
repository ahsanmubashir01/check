import 'package:flutter/material.dart';
import 'package:multi_store_apps/main_screens/Category.dart';
import 'package:multi_store_apps/main_screens/cart.dart';
import 'package:multi_store_apps/main_screens/dashboard.dart';
import 'package:multi_store_apps/main_screens/home.dart';
import 'package:multi_store_apps/main_screens/profile.dart';
import 'package:multi_store_apps/main_screens/stores.dart';
import 'package:multi_store_apps/main_screens/upload_product.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  @override
  _SupplierHomeScreenState createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedindex = 0;
  final List<Widget> _tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
 DashboardScreen(),
    UploadProductScreen(),
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
                (Icons.dashboard), label: 'DashBoard'),
          BottomNavigationBarItem
            (icon: Icon
            (Icons.upload), label: 'Upload'),
        ],
        onTap: (index){
          setState(() {

            _selectedindex=index;

          });
        },
      ),
    );;
  }
}
