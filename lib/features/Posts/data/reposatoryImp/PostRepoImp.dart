import 'package:clean_architecture/core/Exception.dart';
import 'package:clean_architecture/core/checkinternet.dart';
import 'package:clean_architecture/core/failure.dart';
import 'package:clean_architecture/features/Posts/data/datasource/PostLocaldatasource.dart';
import 'package:clean_architecture/features/Posts/data/datasource/PostremouteDatasource.dart';
import 'package:clean_architecture/features/Posts/data/model/postmodel.dart';
import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/domain/reposatory/posts_reposatory.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

class PostRepoImp extends PostsRepo {
  final PostsRemouteDataSource remouteDataSource;
  final PostsLocalDataSource localDataSource;
  PostRepoImp({required this.remouteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    DependecnyInjection.sl<Logger>().i("Start GetData RepoImplement");
    if (await checkInternetConnectivity()) {
      try {
        List<Post> posts = await remouteDataSource.getData();
        localDataSource.cachedPosts(posts);
        DependecnyInjection.sl<Logger>().i("End GetData RepoImplement");
        return right(posts);
      } on ServerException {
        DependecnyInjection.sl<Logger>().i(" GetData ServerFailure");

        return left(ServerFailure());
      }
    } else {
      DependecnyInjection.sl<Logger>().i("Lost Connection to Intrnet");

      try {
        List<Post> data = await localDataSource.getData();
        return right(data);
      } on EmptycaheException {
        return left(EmptycacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModel model = PostModel(
        body: post.body, id: post.id, title: post.title, userId: post.userId);
    if (await checkInternet()) {
      try {
        DependecnyInjection.sl<Logger>().i("Start RepoImplement AddPost");
        remouteDataSource.addPost(model);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if (await checkInternet()) {
      try {
        DependecnyInjection.sl<Logger>().i("Start RepoImplement deletePost");

        remouteDataSource.deletPost(id);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {

    PostModel model = PostModel(
        userId: post.userId, body: post.body, id: post.id, title: post.title);
    if (await checkInternet()) {
      try {
                DependecnyInjection.sl<Logger>().i("Start RepoImplement updatePost");

        remouteDataSource.updatePost(model);

        return right(unit);
      } on ServerException {

        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
