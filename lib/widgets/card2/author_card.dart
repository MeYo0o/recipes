import 'package:flutter/material.dart';
import './author_card/circle_image.dart';
import '../../extensions/stateless_extension.dart';

class AuthorCard extends StatelessWidget {
  // 1
  final String authorName;
  final String title;
  final ImageProvider imageProvider;
  const AuthorCard({
    super.key,
    required this.authorName,
    required this.title,
    required this.imageProvider,
  });

  // 2
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      //2 rows just to apply spaceBetween
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //1
              CircleImage(
                imageProvider: imageProvider,
                imageRadius: 28,
              ),

              const SizedBox(
                width: 8,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    style:
                        extensionTheme(context).textTheme.headline2?.copyWith(
                              color: Colors.black,
                            ),
                  ),
                  Text(
                    title,
                    style:
                        extensionTheme(context).textTheme.headline3?.copyWith(
                              color: Colors.black,
                            ),
                  )
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border_outlined),
            iconSize: 30,
            color: Colors.grey[400],
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              const snackBar = SnackBar(
                content: Text('Favorite Pressed'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
    );
  }
}
