import 'package:flutter/material.dart';

class AoDaiImage extends StatelessWidget {
  final String imagePath;
  final BoxFit? fit;

  const AoDaiImage({super.key, required this.imagePath, this.fit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Image.asset(imagePath, fit: fit),
    );
  }
}
