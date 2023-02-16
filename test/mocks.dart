import 'package:dio/dio.dart';
import 'package:fp_article/feature/posts/application/posts_service.dart';
import 'package:fp_article/feature/posts/data/posts_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsService extends Mock implements PostsService {}

class MockPostsRepository extends Mock implements PostsRepository {}

class MockResponse extends Mock implements Response {}