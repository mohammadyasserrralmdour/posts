import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';


class PostModel extends Post {
  @override
 const PostModel({
    required super.body,
    required super.id,
    required super.title,
    required super.userId,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        body: json["body"],
        id: json["id"],
        title: json["title"],
        userId: json["userId"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userId'] =userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
