// ignore: file_names
import 'package:clean_architecture/core/failure.dart';
import 'package:clean_architecture/features/Posts/domain/reposatory/posts_reposatory.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

class DeletePostsUsesCase {
  final PostsRepo postsRepo;
  const DeletePostsUsesCase({required this.postsRepo});
  Future<Either<Failure,Unit>> call(int post)async{
            DependecnyInjection.sl<Logger>().i("Start UsesCase DeletePostsUsesCase");

    return await postsRepo.deletePost(post);
  }
}