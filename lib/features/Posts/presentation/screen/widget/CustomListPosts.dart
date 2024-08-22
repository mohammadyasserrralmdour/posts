import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/delete_update_screen.dart';
import 'package:flutter/material.dart';

class CustomListPosts extends StatefulWidget {
  final List<Post> posts;
  const CustomListPosts({super.key,required  this.posts, });

  @override
  State<CustomListPosts> createState() => _CustomListPostsState();
}

class _CustomListPostsState extends State<CustomListPosts> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
    itemBuilder: (context, index) {
      return InkWell(onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return  DeleteUpdateScreen(post: widget.posts[index],);
        },));
      },
        child: ListTile(
          leading:Text(widget.posts[index].id.toString()),
          title: Text(widget.posts[index].title.toString(),style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          subtitle: Text(widget.posts[index].body.toString(),style:const TextStyle(fontSize: 15),),
        ),
      );
    },
     separatorBuilder: (context, index) {
       return const Divider(thickness: 1,);
     },
      itemCount: widget.posts.length) ;
  }
}