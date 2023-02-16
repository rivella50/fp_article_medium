import 'package:fp_article/feature/posts/application/posts_service.dart';
import 'package:fp_article/feature/posts/presentation/posts_state.dart';
import 'package:fp_article/utils/async_value_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsController extends StateNotifier<PostsState> {
  PostsController({
    required this.postService,
  }) : super(PostsState(
          posts: [],
          widgetState: const VoidAsyncValue.data(null),
        ));

  final PostsService postService;

  Future<void> getPosts() async {
    state = PostsState(posts: [], widgetState: const VoidAsyncValue.loading());
    final result = await postService.getUnevenPosts();
    result.mapLeft((a) => state = state.copyWith(
        widgetState: VoidAsyncValue.error(a, StackTrace.current)));
    result.map((list) => state =
        PostsState(posts: list, widgetState: const VoidAsyncValue.data(null)));
  }
}

final postsControllerProvider =
    StateNotifierProvider<PostsController, PostsState>((ref) {
  final postsService = ref.watch(postsServiceProvider);
  return PostsController(postService: postsService);
});
