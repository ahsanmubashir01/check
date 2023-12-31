import 'package:flutter/material.dart';
import 'package:multi_store_apps/categories/accessories_categ.dart';
import 'package:multi_store_apps/categories/bags_categ.dart';
import 'package:multi_store_apps/categories/beauty_categ.dart';
import 'package:multi_store_apps/categories/home_garden.dart';
import 'package:multi_store_apps/categories/kids_categ.dart';

import 'package:multi_store_apps/categories/men_categ.dart';

import 'package:multi_store_apps/categories/women_categ.dart';
import 'package:multi_store_apps/main_screens/home.dart';

import '../categories/electronic_categ.dart';
import '../categories/shoes_categ.dart';

List<ItemsData> items = [
  ItemsData(
    label: 'men',
  ),
  ItemsData(
    label: 'women',
  ),
  ItemsData(
    label: 'shoes',
  ),
  ItemsData(
    label: 'bags',
  ),
  ItemsData(
    label: 'electronics',
  ),
  ItemsData(
    label: 'accessories',
  ),
  ItemsData(
    label: 'home & garden',
  ),
  ItemsData(
    label: 'kids',
  ),
  ItemsData(
    label: 'beauty',
  ),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
    }

    setState(() {
      items[0].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const FakeSearch(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: sidenavigator(size),
          ),
          Positioned(bottom: 0, right: 0, child: categview(size)),
        ],
      ),
    );
  }

  Widget sidenavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(index,
                    duration: const Duration(microseconds: 1000),
                    curve: Curves.bounceInOut);
                // for (var element in items) {
                //   element.isSelected = false;
                // }
                //
                // setState(() {
                //   items[index].isSelected = true;
                // });
              },
              child: Container(
                  color: items[index].isSelected == true
                      ? Colors.white
                      : Colors.grey.shade300,
                  height: 100,
                  child: Center(child: Text(items[index].label))),
            );
          }),
    );
  }

  Widget categview(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            for (var element in items) {
              element.isSelected = false;
            }

            setState(() {
              items[value].isSelected = true;
            });
          },
          scrollDirection: Axis.vertical,
          children: const [
            MenCategory(),
            WomenCategory(),
            ShoesCategory(),
            BagsCategory(),
            ElectronicsCategory(),
            AccessoriesCategory(),
            HomeGardenCategory(),
            KidsCategory(),
            BeautyCategory(),
          ]),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;
  ItemsData({required this.label, this.isSelected = false});
}
