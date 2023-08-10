import 'package:flutter/material.dart';

import '../minor_screens/search.dart';

class FakeSearch extends StatefulWidget {
  const FakeSearch({Key? key}) : super(key: key);

  @override
  _FakeSearchState createState() => _FakeSearchState();
}

class _FakeSearchState extends State<FakeSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(child: InkWell(
      onTap: (){
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
          children:  [
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
              width:80,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(child: Text('Search')),
            ),
          ],
        ),
      ),
    ),);
  }
}
