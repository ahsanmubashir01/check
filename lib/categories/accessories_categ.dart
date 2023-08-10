import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class AccessoriesCategory extends StatelessWidget {
  const AccessoriesCategory({Key? key}) : super(key: key);

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
                  headerLabel: 'Accessories',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                      mainAxisSpacing: 60,
                      crossAxisSpacing: 0,
                      crossAxisCount: 3,
                      children: List.generate(accessories.length -1, (index) {
                        return Subcategmodel(
                          mainCategName: 'accessories',
                          subCategName: accessories[index+1],
                          assetName: 'images/accessories/accessories$index.jpg',
                          subcategLabel: accessories[index+1],
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
              maincategName: 'accessories',
            ))
      ],
    );
  }
}
