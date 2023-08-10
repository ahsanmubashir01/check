import 'package:flutter/material.dart';

import '../minor_screens/subcateg_products.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

// List<String> bagstry = ['images/bags/bags0.jpg' , 'images/bags/bags1.jpg'
//     'images/bags/bags2.jpg',
//   'images/bags/bags3.jpg',
//
//
//
// ];

// List<String> labelbags = ['shirt','jeans','shoes','jackets'];
class WomenCategory extends StatelessWidget {
  const WomenCategory({Key? key}) : super(key: key);

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
                  headerLabel: 'Women',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                      mainAxisSpacing: 60,
                      crossAxisSpacing: 0,
                      crossAxisCount: 3,
                      children: List.generate(men.length-1, (index) {
                        return Subcategmodel(
                          mainCategName: 'women',
                          subCategName: women[index+1],
                          assetName: 'images/women/women$index.jpg',
                          subcategLabel: women[index+1],
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
              maincategName: 'men',
            ))
      ],
    );
  }
}
