import 'package:flutter/material.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/decorated_container.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Id: ${post.id}',
            ),
            Text(
              'Title: ${post.title}',
            ),
          ],
        ),
      ),
    );
  }
}
