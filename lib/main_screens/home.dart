import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../galleries/men_gallery.dart';
import '../minor_screens/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const FakeSearch(),
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.yellow,
            indicatorWeight: 6,
            isScrollable: true,
            tabs: [
              RepeatedTab(
                label: 'Men',
              ),
              RepeatedTab(
                label: 'Women',
              ),
              RepeatedTab(
                label: 'Shoes',
              ),
              RepeatedTab(
                label: 'Bags',
              ),
              RepeatedTab(
                label: 'Electronics',
              ),
              RepeatedTab(
                label: 'Accessories',
              ),
              RepeatedTab(
                label: 'Home & Garden',
              ),
              RepeatedTab(
                label: 'Kids',
              ),
              RepeatedTab(
                label: 'Beauty',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MenGalleryScreen(),
            Center(
              child: Text('Women screen'),
            ),
            Center(
              child: Text('Shoes screen'),
            ),
            Center(
              child: Text('Bags screen'),
            ),
            Center(
              child: Text('Electronics screen'),
            ),
            Center(
              child: Text('Accessories screen'),
            ),
            Center(
              child: Text('Home & Garden screen'),
            ),
            Center(
              child: Text('Kids screen'),
            ),
            Center(
              child: Text('Beauty screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow, width: 1.4),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'What are you looking for?',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            Container(
              height: 32,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(child: Text('Search')),
            ),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
