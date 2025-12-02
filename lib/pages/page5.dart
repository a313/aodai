import 'package:flutter/material.dart';

import '../widgets/aodai_image.dart';

class Page5 extends StatelessWidget {
  const Page5({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(child: AoDaiImage(imagePath: image, ratio: 0.8));
  }
}
