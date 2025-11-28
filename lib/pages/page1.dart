import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFFDE7), Color(0xFFFFF3E0), Color(0xFFFFECB3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: _CloudyClipper(),
              child: Container(
                height: size.height * 0.45,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFF176),
                      Color(0xFFFFD54F),
                      Color(0xFFFFB74D),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: _RollingHillsClipper(),
              child: Container(
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFA5D6A7),
                      Color(0xFF81C784),
                      Color(0xFF66BB6A),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 120,
            left: 24,
            child: _FloatingBadge(
              icon: '🎈',
              color: Color(0xFFFF8A80),
              size: 88,
            ),
          ),
          const Positioned(
            top: 90,
            right: 32,
            child: _FloatingBadge(
              icon: '🦋',
              color: Color(0xFFB39DDB),
              size: 76,
            ),
          ),
          const Positioned(
            bottom: 140,
            left: 48,
            child: _FloatingBadge(
              icon: '🌸',
              color: Color(0xFFFFCDD2),
              size: 70,
            ),
          ),
          const Positioned(
            bottom: 110,
            right: 42,
            child: _FloatingBadge(
              icon: '🎠',
              color: Color(0xFF81D4FA),
              size: 82,
            ),
          ),
          ...List.generate(16, (index) {
            final top = (index * 58.0) % (size.height - 120) + 40;
            final left = (index * 87.0) % (size.width - 80) + 20;
            const sparkles = ['✨', '⭐', '🌟', '💫', '🎨'];
            return Positioned(
              top: top,
              left: left,
              child: Text(
                sparkles[index % sparkles.length],
                style: TextStyle(fontSize: 22 + (index % 4) * 5),
              ),
            );
          }),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: const Color(0xFFFFC107),
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC107).withOpacity(0.35),
                            blurRadius: 30,
                            spreadRadius: 4,
                            offset: const Offset(0, 10),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: const [
                          Text(
                            '🎉 Xin chào các bé 🎉',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFF7043),
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Đề Tài',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFD81B60),
                              letterSpacing: 3,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'TRANG TRÍ ÁO DÀI',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6A1B9A),
                              letterSpacing: 4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text(
                        'Cùng nhau khám phá sắc màu áo dài Việt Nam nhé!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00897B),
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
              padding: const EdgeInsets.only(bottom: 26),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Text(
                  'Nhấn mũi tên để bắt đầu hành trình sắc màu nhé! ➡️',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5E35B1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  const _FloatingBadge({
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
        color: color.withOpacity(0.22),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.6), width: 3),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(icon, style: TextStyle(fontSize: size * 0.5)),
    );
  }
}

class _TopicPill extends StatelessWidget {
  const _TopicPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFFB74D), width: 2.5),
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
          color: Color(0xFF6D4C41),
        ),
      ),
    );
  }
}

class _CloudyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path =
        Path()
          ..lineTo(0, size.height * 0.65)
          ..quadraticBezierTo(
            size.width * 0.2,
            size.height,
            size.width * 0.4,
            size.height * 0.7,
          )
          ..quadraticBezierTo(
            size.width * 0.6,
            size.height * 0.45,
            size.width * 0.8,
            size.height * 0.68,
          )
          ..quadraticBezierTo(
            size.width * 0.92,
            size.height * 0.8,
            size.width,
            size.height * 0.65,
          )
          ..lineTo(size.width, 0)
          ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _RollingHillsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path =
        Path()
          ..moveTo(0, size.height * 0.25)
          ..quadraticBezierTo(
            size.width * 0.2,
            size.height * 0.05,
            size.width * 0.45,
            size.height * 0.22,
          )
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.45,
            size.width,
            size.height * 0.2,
          )
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
