import 'package:aodai/pages/page4.dart';
import 'package:aodai/pages/page5.dart';
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
  // Separate image lists for each ActionPage
  final List<int> _actionPage1Images = [1, 2, 3, 4];
  List<int> _actionPage2Images = [1, 2, 3, 4];
  List<int> _actionPage3Images = [1, 2, 3, 4];
  List<int> _actionPage4Images = [1, 2, 3, 4];
  List<Widget> _pages = [];
  // ActionPage indices: 3, 5, 7, 9
  final List<int> _actionPageIndices = [3, 5, 7, 9];
  bool _isInActionPages = false;
  bool _isAnimating = false;
  // Track if user has selected an image for each ActionPage (index 0-3 corresponds to ActionPage 1-4)
  final List<bool> _hasSelectedImageList = [false, false, false, false];
  final List<int> _selectedImage = [-1, -1, -1, -1];

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
      //4
      ActionPage(
        key: ValueKey(_actionPage1Images),
        images: _actionPage1Images,
        onImageSelected:
            (selectedImage, remainingImages) =>
                _handleImageSelected(selectedImage, remainingImages, 1),
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      Page5(
        key: ValueKey(_selectedImage[0]),
        image: "assets/png/${_selectedImage[0]}.png",
      ),
      //3
      ActionPage(
        key: ValueKey(_actionPage2Images),
        images: _actionPage2Images,
        onImageSelected:
            (selectedImage, remainingImages) =>
                _handleImageSelected(selectedImage, remainingImages, 2),
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      Page5(
        key: ValueKey(_selectedImage[1]),
        image: "assets/png/${_selectedImage[1]}.png",
      ),
      //2
      ActionPage(
        key: ValueKey(_actionPage3Images),
        images: _actionPage3Images,
        onImageSelected:
            (selectedImage, remainingImages) =>
                _handleImageSelected(selectedImage, remainingImages, 3),
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      Page5(
        key: ValueKey(_selectedImage[2]),
        image: "assets/png/${_selectedImage[2]}.png",
      ),
      //1
      ActionPage(
        key: ValueKey(_actionPage4Images),
        images: _actionPage4Images,
        onImageSelected:
            (selectedImage, remainingImages) =>
                _handleImageSelected(selectedImage, remainingImages, 4),
        onAnimationStateChanged: _handleAnimationStateChanged,
      ),
      Page5(
        key: ValueKey(_selectedImage[3]),
        image: "assets/png/${_selectedImage[3]}.png",
      ),
      Page7(),
    ];
  }

  void _handleAnimationStateChanged(bool isAnimating) {
    setState(() {
      _isAnimating = isAnimating;
      // When animation completes, mark that user has selected an image for current ActionPage
      if (!isAnimating && _isInActionPages) {
        int actionPageNumber = _actionPageIndices.indexOf(_currentPage);
        if (actionPageNumber >= 0 &&
            actionPageNumber < _hasSelectedImageList.length) {
          _hasSelectedImageList[actionPageNumber] = true;
        }
      }
    });
  }

  void _handleImageSelected(
    int selectedImage,
    List<int> remainingImages,
    int pageNumber,
  ) {
    // Update the corresponding ActionPage's image list
    setState(() {
      switch (pageNumber) {
        case 1:
          _actionPage2Images = remainingImages;
          _selectedImage[0] = selectedImage;
          break;
        case 2:
          _actionPage3Images = remainingImages;
          _selectedImage[1] = selectedImage;
          break;
        case 3:
          _actionPage4Images = remainingImages;
          _selectedImage[2] = selectedImage;
          break;
        case 4:
          _selectedImage[3] = selectedImage;
          break;
      }
      _buildPages();
    });
    // Don't automatically navigate - user must use arrow/swipe
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
            // Chỉ cho phép previous nếu không đang animation
            if (!_isAnimating) {
              _previousPage();
            }
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            // Cho phép next nếu:
            // - Không đang animation
            // - Nếu trong ActionPages thì phải đã click vào ảnh
            bool canNavigate = !_isAnimating;
            if (canNavigate && _isInActionPages) {
              int actionPageNumber = _actionPageIndices.indexOf(_currentPage);
              canNavigate =
                  actionPageNumber >= 0 &&
                  actionPageNumber < _hasSelectedImageList.length &&
                  _hasSelectedImageList[actionPageNumber];
            }
            if (canNavigate) {
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
                // Disable swipe when animating
                // Or when in ActionPages and haven't selected image yet
                _isAnimating ||
                        (_isInActionPages &&
                            _actionPageIndices.contains(_currentPage) &&
                            !_hasSelectedImageList[_actionPageIndices.indexOf(
                              _currentPage,
                            )])
                    ? const NeverScrollableScrollPhysics()
                    : null,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                // Check if we're in ActionPages
                _isInActionPages = _actionPageIndices.contains(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
