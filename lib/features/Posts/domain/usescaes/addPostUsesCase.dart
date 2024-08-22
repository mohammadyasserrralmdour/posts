import 'package:clean_architecture/core/failure.dart';
import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/domain/reposatory/posts_reposatory.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

class AddPostsUsesCase {
  final PostsRepo postsRepo;
  const AddPostsUsesCase({required this.postsRepo});
  Future<Either<Failure,Unit>> call(Post post)async{
    DependecnyInjection.sl<Logger>().i("Start UsesCase AddPostsUsesCase");
    return await postsRepo.addPost(post);
  }
}