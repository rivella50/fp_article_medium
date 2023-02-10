import 'package:flutter/material.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/feature/posts/presentation/post_widget.dart';

class PostsList extends StatelessWidget {
  PostsList({
    Key? key,
    required this.posts,
  }) : super(key: key);

  List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return PostWidget(
          post: posts[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
      itemCount: posts.length,
    );
  }
}
