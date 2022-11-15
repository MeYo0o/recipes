import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.imageRadius = 20,
    required this.imageProvider,
  });

  final double imageRadius;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    // this is just a container like for the padding effect
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: imageRadius,
      //this is the actual image
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
