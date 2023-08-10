import 'package:flutter/material.dart';

import '../minor_screens/subcateg_products.dart';

class Sliderbar extends StatelessWidget {
  final String maincategName;

  const Sliderbar({
    Key? key,
    required this.maincategName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                maincategName == 'beauty'
                    ? Text('')
                    : Text(
                        ' << ',
                        style: style,
                      ),
                Text(
                  maincategName.toUpperCase(),
                  style: style,
                ),
                maincategName == 'men'
                    ? Text('')
                    : Text(
                        ' >> ',
                        style: style,
                      ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(
    color: Colors.brown,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 10);

class Subcategmodel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subcategLabel;
  const Subcategmodel({
    Key? key,
    required this.mainCategName,
    required this.subCategName,
    required this.assetName,
    required this.subcategLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SubCategProducts(
                    subcategName: subCategName,
                    maincategName: mainCategName,
                  )),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(assetName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
            child: Text(subcategLabel , style: TextStyle(fontSize: 11),),
          ),
        ],
      ),
    );
  }
}

class CategheaderLabel extends StatelessWidget {
  final String headerLabel;
  const CategheaderLabel({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        headerLabel,
        style: TextStyle(
            fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 24),
      ),
    );
  }
}
