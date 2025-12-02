import 'package:flutter/material.dart';

import '../widgets/aodai_image.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: AoDaiImage(imagePath: 'assets/png/1.png')),
          Expanded(child: AoDaiImage(imagePath: 'assets/png/2.png')),
          Expanded(child: AoDaiImage(imagePath: 'assets/png/3.png')),
          Expanded(child: AoDaiImage(imagePath: 'assets/png/4.png')),
        ],
      ),
    );
  }
}
