
import 'package:equatable/equatable.dart';

class Post extends Equatable{
  final String? title;
  final String? body;
  final int? id;
  final int? userId;
   const Post(  {required this.userId,required this.body,required this.id,required this.title});
 
  @override
  List<Object?> get props => [title,body,id,userId];
  
}