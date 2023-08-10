import 'package:flutter/material.dart';
import 'package:multi_store_apps/main_screens/profile.dart';
class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(color: Colors.black,
            fontFamily: 'Acme' , fontSize: 24 , letterSpacing: 1.5
        ),

      ),
    );
  }
}
