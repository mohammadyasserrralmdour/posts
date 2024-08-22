part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}


// ignore: must_be_immutable
class PostsInitial extends PostsState{
  String init="Initial";
}



class Loaded extends PostsState{
  final List<Post> posts;
  const Loaded({required this.posts});
   @override
  List<Object> get props => [posts];
}

class LoadingPost extends PostsState{
  
}

class Erorr extends PostsState{
   final String message;
   const Erorr({required this.message});
   @override
  List<Object> get props => [message];
}


