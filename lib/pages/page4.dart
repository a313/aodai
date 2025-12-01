import 'package:aodai/widgets/aodai_image.dart';
import 'package:flutter/material.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({
    super.key,
    required this.images,
    required this.onImageSelected,
    this.onAnimationStateChanged,
  });
  final List<int> images;
  final Function(int selectedImage, List<int> remainingImages) onImageSelected;
  final Function(bool isAnimating)? onAnimationStateChanged;

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  final GlobalKey _whiteImageKey = GlobalKey();
  final List<GlobalKey> _imageKeys = [];
  int? _selectedImage;
  int? _selectedImageIndex;
  Offset? _animatedImagePosition;
  Size? _animatedImageSize;
  Offset? _targetPosition;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    // Create keys for each image
    for (int i = 0; i < widget.images.length; i++) {
      _imageKeys.add(GlobalKey());
    }
  }

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
          // Top-left corner
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
              child: Center(child: Text('🌸', style: TextStyle(fontSize: 40))),
            ),
          ),
          // Top-right corner
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
              child: Center(child: Text('🦋', style: TextStyle(fontSize: 42))),
            ),
          ),
          // Bottom-left corner
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
              child: Center(child: Text('🌈', style: TextStyle(fontSize: 38))),
            ),
          ),
          // Bottom-right corner
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
              child: Center(child: Text('⭐', style: TextStyle(fontSize: 45))),
            ),
          ),
          // Additional playful decorations
          Positioned(
            top: 120,
            left: 100,
            child: Text('🎨', style: TextStyle(fontSize: 32)),
          ),
          Positioned(
            top: 160,
            right: 120,
            child: Text('✨', style: TextStyle(fontSize: 28)),
          ),
          Positioned(
            bottom: 140,
            left: 90,
            child: Text('🌟', style: TextStyle(fontSize: 30)),
          ),
          Positioned(
            bottom: 180,
            right: 100,
            child: Text('🎈', style: TextStyle(fontSize: 34)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 50,
            child: Text('🦄', style: TextStyle(fontSize: 26)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: 60,
            child: Text('🌺', style: TextStyle(fontSize: 28)),
          ),
          // Main layout
          Row(
            children: [
              // White image (target)
              Expanded(
                flex: 1,
                child: Container(
                  key: _whiteImageKey,
                  child: AoDaiImage(imagePath: "assets/png/white.png"),
                ),
              ),
              Container(width: 10, height: double.infinity, color: Colors.grey),
              // Selectable images
              Expanded(
                flex: widget.images.length,
                child: Row(
                  children: List.generate(
                    widget.images.length,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!_isAnimating) {
                            _onImageTapped(widget.images[index], index);
                          }
                        },
                        child: Container(
                          key: _imageKeys[index],
                          child: Opacity(
                            opacity: _selectedImageIndex == index ? 0.0 : 1.0,
                            child: AoDaiImage(
                              imagePath:
                                  "assets/png/${widget.images[index]}.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Animated flying image
          if (_isAnimating &&
              _selectedImage != null &&
              _animatedImagePosition != null &&
              _animatedImageSize != null)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              left: _animatedImagePosition!.dx,
              top: _animatedImagePosition!.dy,
              width: _animatedImageSize!.width,
              height: _animatedImageSize!.height,
              child: Image.asset(
                "assets/png/$_selectedImage.png",
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }

  void _onImageTapped(int imageId, int index) async {
    // Get positions and sizes before animation
    final RenderBox? imageBox =
        _imageKeys[index].currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? whiteImageBox =
        _whiteImageKey.currentContext?.findRenderObject() as RenderBox?;

    if (imageBox == null || whiteImageBox == null) return;

    final imagePosition = imageBox.localToGlobal(Offset.zero);
    final imageSize = imageBox.size;
    final whitePosition = whiteImageBox.localToGlobal(Offset.zero);
    final whiteSize = whiteImageBox.size;

    // Notify parent that animation is starting
    widget.onAnimationStateChanged?.call(true);

    // Start animation from image position
    setState(() {
      _isAnimating = true;
      _selectedImage = imageId;
      _selectedImageIndex = index;
      _animatedImagePosition = imagePosition;
      _animatedImageSize = imageSize;
      _targetPosition = whitePosition;
    });

    // Small delay to ensure first position is rendered
    await Future.delayed(const Duration(milliseconds: 50));

    // Move to target position with white image size
    setState(() {
      _animatedImagePosition = _targetPosition;
      _animatedImageSize = whiteSize;
    });

    // Wait for animation to complete
    await Future.delayed(const Duration(milliseconds: 1000));

    // Delay 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Get remaining images (exclude selected one)
    final remainingImages =
        widget.images.where((img) => img != imageId).toList();

    // Notify parent that animation is complete and ready to move
    widget.onAnimationStateChanged?.call(false);

    // Notify parent to move to next page
    widget.onImageSelected(imageId, remainingImages);
  }
}
