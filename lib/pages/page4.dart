import 'package:aodai/widgets/aodai_image.dart';
import 'package:flutter/material.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({
    super.key,
    required this.images,
    required this.onImageSelected,
  });
  final List<int> images;
  final Function(int selectedImage, List<int> remainingImages) onImageSelected;

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
    return Stack(
      children: [
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
            Container(width: 20, height: double.infinity, color: Colors.grey),
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
                            imagePath: "assets/png/${widget.images[index]}.png",
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

    // Notify parent to move to next page
    widget.onImageSelected(imageId, remainingImages);
  }
}
