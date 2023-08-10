import 'package:flutter/material.dart';
import 'package:multi_store_apps/widgets/appbar_widgets.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,title: AppBarTitle(title: 'Stores',),),
    );
  }
}
