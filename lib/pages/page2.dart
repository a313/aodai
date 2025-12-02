import 'package:flutter/material.dart';

import '../widgets/aodai_image.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AoDaiImage(imagePath: 'assets/png/white.png', ratio: 0.80),
    );
  }
}
