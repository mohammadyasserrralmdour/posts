import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/failure.dart';
import 'package:clean_architecture/features/Posts/data/model/postmodel.dart';
import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/addPostUsesCase.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/deletePostUsescase.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/updatePostUsesCase.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/bloc/posts_bloc.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'add_delete_update_dart_event.dart';
part 'add_delete_update_dart_state.dart';

class AddDeleteUpdateDartBloc
    extends Bloc<AddDeleteUpdateDartEvent, AddDeleteUpdateDartState> {
   AddPostsUsesCase addUsesCase=DependecnyInjection.sl<AddPostsUsesCase>();
   DeletePostsUsesCase deleteUsesCase=DependecnyInjection.sl<DeletePostsUsesCase>();
   UpdatePostsUsesCase updateUsesCase=DependecnyInjection.sl<UpdatePostsUsesCase>();

  AddDeleteUpdateDartBloc(
   
  ) : super(AddDeleteUpdateDartInitial()) {

    on<AddDeleteUpdateDartEvent>((event, emit) async {
      if (event is AddPostsEvent) {
        try{
 PostModel  post=PostModel(userId: event.post.userId, body: event.post.body, id: event.post.id, title: event.post.title);
          postscreen.add(post);
          postscreen.sort((a,b)=>a.id!.compareTo(b.id!));
        }catch(e,s){
           DependecnyInjection.sl<Logger>().e("$e $s");
        }
        
        DependecnyInjection.sl<Logger>().i("===============Add id is${event.post.id}===============");
       testEvent(addUsesCase(event.post));
      } 
      else if (event is DeletePostsEvent) {
        postscreen= postscreen.where((post) =>post.id!= event.id,).toList();
        DependecnyInjection.sl<Logger>().i("===============Delete===============");
        testEvent(deleteUsesCase(event.id));
      }
       else if (event is UpdatePostsEvent) {
        
        postscreen= postscreen.map<Post>((post) {
          if(post.id!= event.post.id){
             return post;
          }else{
            return event.post;
          }
        } 
        ,).toList();
        DependecnyInjection.sl<Logger>().i("===============Update===============");
        testEvent(updateUsesCase(event.post));
      }
    });
   
  }
   Future testEvent(Future<Either<Failure,Unit>> function)async{
      // ignore: invalid_use_of_visible_for_testing_member
      emit(Loading());
     await Future.delayed(const Duration(seconds: 2));
        final data = await function;
        // ignore: invalid_use_of_visible_for_testing_member
        data.fold((failure) => emit(const Error(message: "Error")),
         // ignore: invalid_use_of_visible_for_testing_member
            (unit) => emit(const Success(message: "Success")));
    }
}
