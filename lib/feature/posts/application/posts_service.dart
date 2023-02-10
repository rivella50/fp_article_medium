import 'dart:async';

import 'package:fp_article/feature/posts/data/posts_repository.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsService {
  PostsService(this.ref);
  final Ref ref;

  Future<Either<ApiException, List<Post>>> getUnevenPosts() async {
    final repository = ref.read(postsRepositoryProvider);
    await Future.delayed(const Duration(milliseconds: 250));
    final result = await repository.getPosts().run();
    return result.map((list) => list.where((post) => post.id!.isOdd).toList());
  }
}

final postsServiceProvider = Provider<PostsService>((ref) {
  return PostsService(ref);
});
