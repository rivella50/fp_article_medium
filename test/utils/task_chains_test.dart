import 'package:flutter_test/flutter_test.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/exceptions.dart';
import 'package:fp_article/utils/task_chains.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group('all groups', () {
    late MixinClass mixinClass;

    group('errorOrBody', () {
      late MockResponse response;
      setUp(() {
        response = MockResponse();
        mixinClass = MixinClass();
      });
      test('errorOrBody, success', () {
        when(() => response.statusCode)
            .thenAnswer((_) => 200);
        when(() => response.data)
            .thenAnswer((_) => [Post(id: 1)]);
        final result = mixinClass.errorOrBody(response);
        expect(
          result.isRight(),
          true,
        );
        expect(
          result
              .getRight()
              .getOrElse(() => [])
              .length,
          1,
        );
      });
      test('errorOrBody, failure 404', () {
        when(() => response.statusCode)
            .thenAnswer((_) => 404);
        final result = mixinClass.errorOrBody(response);
        expect(
          result.isLeft(),
          true,
        );
      });
    });

    group('errorOrPosts', () {
      late List<Map<String, dynamic>> json;
      setUp(() {
        mixinClass = MixinClass();
      });
      test('errorOrPosts, success', () {
        json = [{'id':1, 'title':'first'}, {'id':2, 'title':'second'}];
        final result = mixinClass.errorOrPosts(json);
        expect(
          result.isRight(),
          true,
        );
        expect(
          result.getRight().getOrElse(() => []).length,
          2,
        );
      });
      test('errorOrPosts, failure', () {
        json = [{'id':'wrong type', 'title':'first'}];
        final result = mixinClass.errorOrPosts(json);
        expect(
          result.isLeft(),
          true,
        );
        expect(
          result.getLeft().getOrElse(() => ApiException(message: 'else message')).message,
          "type 'String' is not a subtype of type 'int?' in type cast",
        );
      });
    });
  });
}

class MixinClass with TaskChains {}