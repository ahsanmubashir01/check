import 'package:flutter/material.dart';
import 'package:multi_store_apps/main_screens/customer_home.dart';
import 'package:multi_store_apps/main_screens/dashboard.dart';
import 'package:multi_store_apps/main_screens/home.dart';
import 'package:multi_store_apps/widgets/appbar_widgets.dart';
import '../widgets/yellow_button.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({Key? key, this.back}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: widget.back,
            elevation: 0,
            backgroundColor: Colors.white,
            title: AppBarTitle(
              title: 'Cart',
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Cart Is Empty !',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 50,
                ),
                Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(25),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () {
                      Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : Navigator.pushReplacementNamed(
                              context, '/customer_home');
                    },
                    child: Text(
                      'Continue Shopping',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Total: \$ ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '00.00: \$ ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                YellowButton(
                  width: 0.45,
                  label: 'CheckOUT',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
