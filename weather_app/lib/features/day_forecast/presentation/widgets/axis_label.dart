import 'package:flutter/material.dart';
import 'package:weather_app/core/common/widgets/positioned_widget.dart';

class AxisLabel extends StatelessWidget {
  final String text;
  final double xInPixelFormat;
  final double yInPixelFormat;

  const AxisLabel({
    super.key,
    required this.text,
    required this.xInPixelFormat,
    required this.yInPixelFormat,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedWidget(
      x: xInPixelFormat,
      y: yInPixelFormat,
      child: IgnorePointer(
        child: SizedBox(
          width: 40,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
