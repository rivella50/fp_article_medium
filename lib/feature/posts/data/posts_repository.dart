import 'package:dio/dio.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/constants.dart';
import 'package:fp_article/utils/exceptions.dart';
import 'package:fp_article/utils/task_chains.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsRepository with TaskChains {
  TaskEither<ApiException, List<Post>> getPosts() {
    var dio = Dio();
    return TaskEither<ApiException, Response>.tryCatch(
      () => dio.get('$jsonPlaceholderBaseUrl/posts'),
      (object, stackTrace) => ApiErrorHandler.handleError(object),
    ).chainEither(errorOrBody).chainEither(errorOrPosts);
  }
}

final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  return PostsRepository();
});
