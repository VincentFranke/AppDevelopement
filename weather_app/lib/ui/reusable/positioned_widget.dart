import 'package:flutter/material.dart';

class PositionedWidget extends StatelessWidget {
  final double x;
  final double y;
  final Widget child;
  const PositionedWidget({
    super.key,
    required this.x,
    required this.y,
    required this.child,
  });
  // versuche gerade die Position dynamisch zu setzen wenn man wie im auskommentierten code eine feste größe benutzt klappt es ich will es aber dynamisch haben
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      bottom: y,
      child: FractionalTranslation(
        translation: Offset(-0.5, 0.5),
        child: child,
      ),
    );
  }
}
