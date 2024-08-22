// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/failure.dart';
import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/getpostsUsesCase.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

List<Post> postscreen=[];

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUsesCase getpostUsesCase;
  
  PostsBloc({required this.getpostUsesCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        emit(LoadingPost());
        final post = await getpostUsesCase();
        post.fold(
            (failure) => emit(Erorr(message: getMessagefromFailure(failure))),
            (posts) {
              postscreen=posts;
              emit(Loaded(posts: posts));} 
            )
            ;
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPost());
          final post = await getpostUsesCase();
          post.fold((failure) => emit(const Erorr(message: "message")),
              (posts) => emit(Loaded(posts: postscreen)));
      }
    });
  }

  read(RefreshPostsEvent refreshPostsEvent) {}
}

String getMessagefromFailure(Failure failure) {
  String message = "";
  switch (failure.runtimeType) {
    case ServerFailure:
      message = "ServerFailure";
      break;
    case EmptycacheFailure:
      message = "EmptycacheFailure";
      break;
    case OfflineFailure:
      message = "OfflineFailure";
      break;
    default:
      message;
  }
  return message;
}
