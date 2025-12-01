import 'package:aodai/pages/page4.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/page7.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AoDaiPageView(),
    );
  }
}

class AoDaiPageView extends StatefulWidget {
  const AoDaiPageView({super.key});

  @override
  State<AoDaiPageView> createState() => _AoDaiPageViewState();
}

class _AoDaiPageViewState extends State<AoDaiPageView> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;
  List<int> _currentImages = [1, 2, 3, 4];
  List<Widget> _pages = [];
  final int _firstActionPageIndex = 3; // Index của ActionPage đầu tiên
  final int _lastActionPageIndex = 6; // Index của ActionPage cuối cùng
  bool _isInActionPages = false;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _buildPages();
  }

  void _buildPages() {
    _pages = [
      Page1(),
      Page2(),
      Page3(),
      ActionPage(
        images: _currentImages,
        onImageSelected: _handleImageSelected,
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      ActionPage(
        images: _currentImages,
        onImageSelected: _handleImageSelected,
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      ActionPage(
        images: _currentImages,
        onImageSelected: _handleImageSelected,
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      ActionPage(
        images: _currentImages,
        onImageSelected: _handleImageSelected,
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      Page7(),
    ];
  }

  void _handleAnimationStateChanged(bool isAnimating) {
    setState(() {
      _isAnimating = isAnimating;
    });
  }

  void _handleImageSelected(int selectedImage, List<int> remainingImages) {
    if (remainingImages.isEmpty) {
      // No more images, go to final page
      setState(() {
        _isInActionPages = false;
      });
      _nextPage();
    } else {
      // Update images and rebuild ActionPage
      setState(() {
        _currentImages = remainingImages;
        _buildPages();
      });
      // Move to next page (which is the new ActionPage with remaining images)
      _nextPage();
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _carouselController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _carouselController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            // Chỉ cho phép previous nếu không ở trong ActionPages và không đang animation
            if (!_isInActionPages && !_isAnimating) {
              _previousPage();
            }
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            // Chỉ cho phép next nếu không ở trong ActionPages và không đang animation
            if (!_isInActionPages && !_isAnimating) {
              _nextPage();
            }
          }
        }
      },
      child: Scaffold(
        body: CarouselSlider(
          carouselController: _carouselController,
          items: _pages,
          options: CarouselOptions(
            height: double.infinity,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            scrollPhysics:
                (_isInActionPages || _isAnimating)
                    ? const NeverScrollableScrollPhysics()
                    : null,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                // Check if we're in ActionPages range
                _isInActionPages =
                    index >= _firstActionPageIndex &&
                    index <= _lastActionPageIndex;
              });
            },
          ),
        ),
      ),
    );
  }
}
