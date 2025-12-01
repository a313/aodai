import 'package:flutter/material.dart';

import '../widgets/aodai_image.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles at 4 corners
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF81C784).withOpacity(0.35),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('🌼', style: TextStyle(fontSize: 40))),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                color: Color(0xFF66BB6A).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('🐝', style: TextStyle(fontSize: 42))),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50).withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('☀️', style: TextStyle(fontSize: 38))),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Color(0xFF81C784).withOpacity(0.32),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('🌻', style: TextStyle(fontSize: 45))),
            ),
          ),
          // Additional decorations
          Positioned(
            top: 120,
            left: 100,
            child: Text('🍀', style: TextStyle(fontSize: 32)),
          ),
          Positioned(
            top: 160,
            right: 120,
            child: Text('🌿', style: TextStyle(fontSize: 28)),
          ),
          Positioned(
            bottom: 140,
            left: 90,
            child: Text('🪴', style: TextStyle(fontSize: 30)),
          ),
          Positioned(
            bottom: 180,
            right: 100,
            child: Text('🌷', style: TextStyle(fontSize: 34)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 50,
            child: Text('🦋', style: TextStyle(fontSize: 26)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: 60,
            child: Text('🌺', style: TextStyle(fontSize: 28)),
          ),
          // Main content
          Center(child: AoDaiImage(imagePath: 'assets/png/white.png')),
        ],
      ),
    );
  }
}
