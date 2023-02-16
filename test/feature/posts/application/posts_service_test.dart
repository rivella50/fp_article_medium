import 'package:flutter_test/flutter_test.dart';
import 'package:fp_article/feature/posts/application/posts_service.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  group('getUnevenPosts', ()
  {
    late MockPostsRepository repository;
    late PostsService service;
    setUp(() {
      repository = MockPostsRepository();
      service = PostsService(repository: repository);
    });

    test('get uneven posts, success', () async {
      when(() => repository.getPosts())
        .thenAnswer((_) => TaskEither.right([Post(id: 1), Post(id: 2), Post(id: 3)]));
      final response = await service.getUnevenPosts();
      expect(
        response.isRight(),
        true,
      );
      expect(
        response.getRight().getOrElse(() => []).length,
        2,
      );
    });

    test('get uneven posts, failure: 404 NotFoundException', () async {
      when(() => repository.getPosts())
          .thenAnswer((_) => TaskEither.left(NotFoundException()));
      final response = await service.getUnevenPosts();
      expect(
        response.isLeft(),
        true,
      );
      expect(
        response.getLeft().getOrElse(() => ApiException(message: 'error')),
        NotFoundException(),
      );
    });
  });
}