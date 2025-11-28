import 'package:flutter/material.dart';

class Page7 extends StatelessWidget {
  const Page7({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F5E9), Color(0xFFFFF3E0), Color(0xFFFFEBEE)],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: _RainbowSwoopClipper(),
              child: Container(
                height: size.height * 0.4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFCDD2),
                      Color(0xFFFFAB91),
                      Color(0xFFFFCC80),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: _CozyHillsClipper(),
              child: Container(
                height: size.height * 0.38,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB2EBF2),
                      Color(0xFF80DEEA),
                      Color(0xFF4DD0E1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 110,
            left: 36,
            child: _CelebrationBadge(
              icon: '🎈',
              color: Color(0xFFFF8A80),
              size: 84,
            ),
          ),
          const Positioned(
            top: 70,
            right: 42,
            child: _CelebrationBadge(
              icon: '🎉',
              color: Color(0xFFFFD740),
              size: 76,
            ),
          ),
          const Positioned(
            bottom: 150,
            left: 54,
            child: _CelebrationBadge(
              icon: '🪁',
              color: Color(0xFF81C784),
              size: 72,
            ),
          ),
          const Positioned(
            bottom: 120,
            right: 36,
            child: _CelebrationBadge(
              icon: '🌈',
              color: Color(0xFF9575CD),
              size: 86,
            ),
          ),
          ...List.generate(20, (index) {
            final top = (index * 52.0) % (size.height - 120) + 40;
            final left = (index * 71.0) % (size.width - 60) + 18;
            const confetti = ['✨', '⭐', '🌟', '💫', '🎊'];
            return Positioned(
              top: top,
              left: left,
              child: Text(
                confetti[index % confetti.length],
                style: TextStyle(fontSize: 20 + (index % 3) * 6),
              ),
            );
          }),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(
                          color: const Color(0xFF4FC3F7),
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4FC3F7).withOpacity(0.3),
                            blurRadius: 28,
                            spreadRadius: 4,
                            offset: const Offset(0, 10),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: const [
                          Text(
                            '🎊 Kết Thúc Hành Trình 🎊',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0288D1),
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Các bé đã trang trí áo dài thật tuyệt!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6A1B9A),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Wrap(
                    //   alignment: WrapAlignment.center,
                    //   spacing: 14,
                    //   runSpacing: 12,
                    //   children: const [
                    //     _SparklePill(label: '🎨 Biết pha màu thật đẹp'),
                    //     _SparklePill(label: '🌸 Vẽ hoa văn nhẹ nhàng'),
                    //     _SparklePill(label: '💃 Tự tin khoe áo dài'),
                    //     _SparklePill(label: '🎵 Hát và múa vui tươi'),
                    //   ],
                    // ),
                    // const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xFFFFB74D),
                          width: 3,
                        ),
                      ),
                      child: const Text(
                        'Xin cảm ơn và hẹn gặp lại!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5E35B1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF81D4FA),
                    width: 2.5,
                  ),
                ),
                child: const Text(
                  'Hẹn gặp lại trong tiết học sau nhé các bé! 👋',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00838F),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CelebrationBadge extends StatelessWidget {
  const _CelebrationBadge({
    required this.icon,
    required this.color,
    this.size = 72,
  });

  final String icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.6), width: 3),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.28),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(icon, style: TextStyle(fontSize: size * 0.5)),
    );
  }
}

class _SparklePill extends StatelessWidget {
  const _SparklePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFFCC80), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5D4037),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _RainbowSwoopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path =
        Path()
          ..lineTo(0, size.height * 0.6)
          ..quadraticBezierTo(
            size.width * 0.24,
            size.height * 0.95,
            size.width * 0.5,
            size.height * 0.58,
          )
          ..quadraticBezierTo(
            size.width * 0.76,
            size.height * 0.2,
            size.width,
            size.height * 0.45,
          )
          ..lineTo(size.width, 0)
          ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _CozyHillsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path =
        Path()
          ..moveTo(0, size.height * 0.3)
          ..quadraticBezierTo(
            size.width * 0.2,
            size.height * 0.05,
            size.width * 0.45,
            size.height * 0.28,
          )
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.55,
            size.width,
            size.height * 0.25,
          )
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
