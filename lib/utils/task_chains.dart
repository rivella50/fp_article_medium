import 'package:dio/dio.dart';
import 'package:fp_article/feature/posts/domain/post.dart';
import 'package:fp_article/utils/exceptions.dart';
import 'package:fpdart/fpdart.dart';

mixin TaskChains {
  Either<ApiException, List<dynamic>> errorOrBody(Response response) =>
      Either<ApiException, Response>.fromPredicate(
        response,
        (r) => r.statusCode! >= 200 && r.statusCode! < 300,
        (response) => ApiErrorHandler.handleError(response.data),
      ).map((r) => r.data);

  Either<ApiException, List<Post>> errorOrPosts(List<dynamic> list) =>
      Either.tryCatch(
        () => list.map((map) => Post.fromJson(map)).toList(),
        (object, stackTrace) => ApiErrorHandler.handleError(object),
      );
}
