import 'dart:convert';

import 'package:clean_architecture/core/Exception.dart';
import 'package:clean_architecture/features/Posts/data/model/postmodel.dart';
import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getData();
  Future<Unit> cachedPosts(List<Post> posts);
}

class PostsLocalDataSourceImp extends PostsLocalDataSource {
  final SharedPreferences sharedprefrences;
  PostsLocalDataSourceImp({required this.sharedprefrences});
  @override
  cachedPosts(List<Post> posts) {
    DependecnyInjection.sl<Logger>().i(" Start CachedData");

    List<PostModel> postsModel = posts
        .map<PostModel>((post) => PostModel(
            body: post.body,
            id: post.id,
            title: post.title,
            userId: post.userId))
        .toList();
    List<Map<String, dynamic>> tojson =
        postsModel.map<Map<String, dynamic>>((post) => post.toJson()).toList();
    var tostring = json.encode(tojson);
    sharedprefrences.setString("Posts", tostring);
    DependecnyInjection.sl<Logger>().i(" End CachedData");

    return Future.value(unit);
  }

  @override
  getData() async {
    DependecnyInjection.sl<Logger>().i("Start GetData From Cached");

    var jsonString = sharedprefrences.getString("Posts");
    if (jsonString != null) {
      try {
        Future.delayed(const Duration(seconds: 2), () {
          List<PostModel> data = (json.decode(jsonString))
              .map<PostModel>((e) => PostModel.fromJson(e))
              .toList();
          DependecnyInjection.sl<Logger>().i("End GetData From Cached");

          return Future.value(data);
        });

        List<PostModel> data = (json.decode(jsonString))
            .map<PostModel>((e) => PostModel.fromJson(e))
            .toList();
        DependecnyInjection.sl<Logger>().i("End GetData From Cached");

        return Future.value(data);
      } catch (e, s) {
        DependecnyInjection.sl<Logger>().e("Stack Erorr is$s");
        throw DataCachedException();
      }
    } else {
      throw EmptycaheException();
    }
  }
}
