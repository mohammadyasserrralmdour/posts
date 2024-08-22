part of 'add_delete_update_dart_bloc.dart';

sealed class AddDeleteUpdateDartEvent extends Equatable {
  const AddDeleteUpdateDartEvent();

  @override
  List<Object> get props => [];
}

class AddPostsEvent extends AddDeleteUpdateDartEvent{
  final Post post;
  const AddPostsEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class DeletePostsEvent extends AddDeleteUpdateDartEvent{
final int id;
const DeletePostsEvent({required this.id});
@override
  List<Object> get props => [id];
}

class UpdatePostsEvent extends AddDeleteUpdateDartEvent{
  final Post post;
  const UpdatePostsEvent({required this.post});
  @override
  List<Object> get props => [post];
}
