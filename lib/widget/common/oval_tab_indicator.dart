import 'package:flutter/material.dart';

class RoundedRectTabIndicator extends Decoration {
  final Color color;
  final double radius;
  final double width;
  final double height;

  RoundedRectTabIndicator({
    required this.color,
    required this.radius,
    required this.width,
    required this.height,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _RoundedRectPainter(
      color: color,
      radius: radius,
      width: width,
      height: height,
    );
  }
}

class _RoundedRectPainter extends BoxPainter {
  final double radius;
  final double width;
  final double height;
  final Color color;

  _RoundedRectPainter({
    required this.color,
    required this.radius,
    required this.width,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint _paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    final Rect rect = Rect.fromCenter(
      center: offset +
          Offset(configuration.size!.width / 2,
              configuration.size!.height - height / 2),
      width: width,
      height: height,
    );

    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(radius),
    );

    canvas.drawRRect(rrect, _paint);
  }
}
