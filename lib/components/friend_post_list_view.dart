import 'package:flutter/material.dart';

import '../models/post.dart';
import 'components.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({
    super.key,
    required this.friendPosts,
  });

  final List<Post> friendPosts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 0,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //4
          Text(
            'Social Chefs ! 👨‍🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          // 5
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friendPosts.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemBuilder: (context, index) {
              final post = friendPosts[index];
              return FriendPostTile(post: post);
            },
          ),
          // 6
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
