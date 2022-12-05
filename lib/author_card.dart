import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';

import 'circle_image.dart';

class AuthorCard extends StatefulWidget {
  // 1
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const AuthorCard({
    super.key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  });

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    print('initState gets called');
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies gets called');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AuthorCard oldWidget) {
    print('didUpdateWidget gets called');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate gets called');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose gets called');
    super.dispose();
  }

  // 2
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage(
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorName,
                    style: FooderlichTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    widget.title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  )
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            iconSize: 30,
            color: Colors.red,
            onPressed: () {
              //3
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
    );
  }
}
