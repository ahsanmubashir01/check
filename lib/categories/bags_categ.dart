import 'package:flutter/material.dart';

import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class BagsCategory extends StatelessWidget {
  const BagsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              children: [
                CategheaderLabel(
                  headerLabel: 'Bags',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                      mainAxisSpacing: 60,
                      crossAxisSpacing: 0,
                      crossAxisCount: 3,
                      children: List.generate(bags.length-1, (index) {
                        return Subcategmodel(
                          mainCategName: 'bags',
                          subCategName: bags[index+1],
                          assetName: 'images/bags/bags$index.jpg',
                          subcategLabel: bags[index+1],
                        );
                      })),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Sliderbar(
              maincategName: 'bags',
            ))
      ],
    );
  }
}