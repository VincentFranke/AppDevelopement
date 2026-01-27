import 'package:flutter/widgets.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerWrapper extends StatelessWidget {
  final bool applyShimmer;
  final Widget Function(Widget? child) skeleton;
  final Widget? childToShowWhenNoShimmer;
  const ShimmerWrapper({
    super.key,
    required this.applyShimmer,
    required this.skeleton,
    this.childToShowWhenNoShimmer,
  });

  @override
  Widget build(BuildContext context) {
    final body = skeleton(applyShimmer ? null : childToShowWhenNoShimmer);

    return applyShimmer
        ? Shimmer(duration: Duration(milliseconds: 1500), child: body)
        : body;
  }
}
