// ignore_for_file: file_names

import 'dart:convert';

import 'package:clean_architecture/core/Exception.dart';
import 'package:clean_architecture/core/constant.dart';
import 'package:clean_architecture/features/Posts/data/model/postmodel.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class PostsRemouteDataSource {
  Future<List<PostModel>> getData();
  Future<Unit> addPost(PostModel post);
  Future<Unit> deletPost(int id);
  Future<Unit> updatePost(PostModel post);
}

class PostsRemoteDataSourceImp extends PostsRemouteDataSource {
  final http.Client client;
  PostsRemoteDataSourceImp({required this.client});

  @override
  getData() async {
    try {
      DependecnyInjection.sl<Logger>().i("Start PostsRemouteDataSource");

      Logger().i("start Api");
      String url = "${baseurl}posts";
      final response = await client
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
      Logger().i("Data present");
      List<PostModel> data = (json.decode(response.body))
          .map<PostModel>((e) => PostModel.fromJson(e))
          .toList();
      Logger().i("Success  Decode");

      return data;
    } catch (e, s) {
      DependecnyInjection.sl<Logger>()
          .w("Erorr Api is ${e.runtimeType}   stack $s");
      throw ServerException;
    }
  }

  @override
  addPost(PostModel post) async {
    //    Map body = {"title": post.title, "body": post.body,"id":post.id,"userId":1};

    Map body = {"title": post.title, "body": post.body};

    var response = await client.post(Uri.parse(baseurl + "posts/"), body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      DependecnyInjection.sl<Logger>().i("Success Add Post ");
       return Future.value(unit);
    } else {
      DependecnyInjection.sl<Logger>().i("Failure Add Post Statuscode is${response.statusCode} ");

     throw ServerException();
    }
  }

  @override
  deletPost(int id) async {
    var response =
        await client.delete(Uri.parse(baseurl + "posts/${id.toString()}"));
    if (response.statusCode == 200 || response.statusCode == 201) {
            DependecnyInjection.sl<Logger>().i("Success delete Post ");

      return Future.value(unit);
    } else {
            DependecnyInjection.sl<Logger>().i("Failure Delter Post Statuscode is${response.statusCode} ");

      throw ServerException();
    }
  }

  @override
  updatePost(PostModel post) async {
    Map body = {
      "title": post.title,
      "body": post.body,
    };
final response = await http.patch(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': 'foo',
    }),
  );
    // var response = await client
    //     .patch(Uri.parse(baseurl + "posts/${post.id}"), body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
                  DependecnyInjection.sl<Logger>().i("Success Update Post");

      return Future.value(unit);
    } else {
                  DependecnyInjection.sl<Logger>().i("Failure Update Post Statuscode is${response.statusCode} ");

      throw ServerException();
    }
  }
}
