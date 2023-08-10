import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_apps/dashboard_components/edit_business.dart';
import 'package:multi_store_apps/dashboard_components/manage_products.dart';
import 'package:multi_store_apps/dashboard_components/my_store.dart';
import 'package:multi_store_apps/dashboard_components/supp_balance.dart';
import 'package:multi_store_apps/dashboard_components/supp_statics.dart';
import 'package:multi_store_apps/dashboard_components/suppl_orders.dart';
import 'package:multi_store_apps/widgets/appbar_widgets.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics'
];

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.store
];

List<Widget> pages = [
  MyStore(),
  SupplierOrders(),
  EditBusiness(),
  ManageProducts(),
  BalanceScreen(),
  StaticsScreen(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: AppBarTitle(
            title: 'Dahboard',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/welcome_screen');
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: GridView.count(
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            children: List.generate(
              6,
              (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => pages[index]));
                  },
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.purpleAccent.shade200,
                    color: Colors.blueGrey.withOpacity(0.7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icons[index],
                          size: 32,
                          color: Colors.yellowAccent,
                        ),
                        Text(
                          label[index].toUpperCase(),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Acme',
                              letterSpacing: 2,
                              color: Colors.yellowAccent),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
