import 'package:flutter/material.dart';

class AoDaiImage extends StatelessWidget {
  final String imagePath;
  final BoxFit? fit;
  final double ratio;

  const AoDaiImage({
    super.key,
    required this.imagePath,
    this.fit,
    this.ratio = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * ratio,
      child: Image.asset(imagePath, fit: fit),
    );
  }
}
