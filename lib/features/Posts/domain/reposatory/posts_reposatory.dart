
import 'package:clean_architecture/core/failure.dart';
import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepo{
  
  Future<Either<Failure,List<Post>>> getPosts();

 Future<Either<Failure,Unit>> deletePost(int id);

  Future<Either<Failure,Unit>> addPost(Post post);

  Future<Either<Failure,Unit>> updatePost(Post post);
  
}