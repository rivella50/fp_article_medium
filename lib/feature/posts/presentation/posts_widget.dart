import 'package:flutter/material.dart';
import 'package:fp_article/feature/posts/presentation/posts_controller.dart';
import 'package:fp_article/feature/posts/presentation/posts_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsWidget extends HookConsumerWidget {
  PostsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postsControllerProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: state.widgetState is AsyncLoading
                  ? null
                  : () => ref.read(postsControllerProvider.notifier).getPosts(),
              child: const Text('Load Posts')),
          Visibility(
            visible: state.posts.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: PostsList(
                posts: state.posts,
              ),
            ),
          ),
          Visibility(
            visible: state.widgetState is AsyncError,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                state.widgetState.error.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
