import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final String header;
  final double height;
  const HeaderCard({super.key, required this.header, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(child: Align(child: Text(header))),
    );
  }
}
