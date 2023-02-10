import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/async_value_ui.dart';

class PostsState {
  PostsState({
    required this.posts,
    required this.widgetState,
  });

  PostsState copyWith({
    List<Post>? posts,
    VoidAsyncValue? widgetState,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      widgetState: widgetState ?? this.widgetState,
    );
  }

  final List<Post> posts;
  final VoidAsyncValue widgetState;
}
