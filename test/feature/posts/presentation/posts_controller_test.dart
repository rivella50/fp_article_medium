import 'package:flutter_test/flutter_test.dart';
import 'package:fp_article/feature/posts/presentation/posts_controller.dart';
import 'package:fp_article/utils/exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  group('getPosts', () {
    late MockPostsService postsService;
    late PostsController controller;
    setUp(() {
      postsService = MockPostsService();
      controller = PostsController(postService: postsService);
    });
    test('get posts, success', () async {
      when(() => postsService.getUnevenPosts())
          .thenAnswer((_) => Future.value(Either.right([])));
      await controller.getPosts();
      expect(
        controller.debugState.widgetState,
        const AsyncData<void>(null),
      );
    });

    test('get posts, failure', () async {
      when(() => postsService.getUnevenPosts())
          .thenAnswer((_) => Future.value(Either.left(ApiException(message: 'failure'))));
      await controller.getPosts();
      expect(
        controller.debugState.widgetState.error,
        ApiException(message: 'failure'),
      );
    });
  });
}
