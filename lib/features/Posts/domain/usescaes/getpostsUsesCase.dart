import 'package:clean_architecture/core/failure.dart';
import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/domain/reposatory/posts_reposatory.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

class GetPostsUsesCase {
  final PostsRepo postsRepo;
  const GetPostsUsesCase({required this.postsRepo});
  Future<Either<Failure,List<Post>>> call()async{
DependecnyInjection.sl<Logger>().i("Start GetData RepoImplement");  
  return await postsRepo.getPosts();
  }
}