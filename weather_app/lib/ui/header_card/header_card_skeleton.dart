import 'package:flutter/material.dart';

class HeaderCardSkeleton extends StatelessWidget {
  final Widget? child;
  const HeaderCardSkeleton({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ColoredBox(
        color: Colors.blue.withValues(alpha: 0.5),
        child: child,
      ),
    );
  }
}
