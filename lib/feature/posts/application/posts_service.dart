import 'dart:async';

import 'package:fp_article/feature/posts/data/posts_repository.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsService {
  PostsService(this.ref);
  final Ref ref;

  Future<Either<ApiException, List<Post>>> getUnevenPosts() {
    final repository = ref.read(postsRepositoryProvider);
    return repository.getPosts().flatMap(TaskEither.tryCatchK(
      (list) async => list.where((post) => post.id!.isOdd).toList(),
      (_, __) => ApiException(message: 'error when filtering posts'),
    )).run();
  }
}

final postsServiceProvider = Provider<PostsService>((ref) {
  return PostsService(ref);
});
