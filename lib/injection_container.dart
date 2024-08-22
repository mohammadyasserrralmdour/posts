import 'package:clean_architecture/features/Posts/data/datasource/PostLocaldatasource.dart';
import 'package:clean_architecture/features/Posts/data/datasource/PostremouteDatasource.dart';
import 'package:clean_architecture/features/Posts/data/reposatoryImp/PostRepoImp.dart';
import 'package:clean_architecture/features/Posts/domain/reposatory/posts_reposatory.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/addPostUsesCase.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/deletePostUsescase.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/getpostsUsesCase.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/updatePostUsesCase.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/add_delete_update/add_delete_update_dart_bloc.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart'  ;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:http/http.dart'  as http ;




  class  DependecnyInjection {
    static final sl=GetIt.instance;
   static Future<void> init()async{

  final  sharedPreferences= await SharedPreferences.getInstance(); 
 sl.registerLazySingleton<SharedPreferences>( ()=> sharedPreferences);

  sl.registerFactory<Logger>(() => Logger());
                   //Bloc

  sl.registerFactory<AddDeleteUpdateDartBloc>(() => AddDeleteUpdateDartBloc( ));
  
            
                    //UsesCase

  sl.registerLazySingleton<AddPostsUsesCase>(() => AddPostsUsesCase(postsRepo: sl()));

  sl.registerLazySingleton<DeletePostsUsesCase>(() => DeletePostsUsesCase(postsRepo: sl()));

  sl.registerLazySingleton<UpdatePostsUsesCase>(() => UpdatePostsUsesCase(postsRepo: sl()));

  sl.registerLazySingleton<GetPostsUsesCase>(() => GetPostsUsesCase(postsRepo: sl()));

   sl.registerLazySingleton<PostsRemouteDataSource>(() => PostsRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<PostsRepo>(() => PostRepoImp(localDataSource: sl(),remouteDataSource: sl()));
 

  sl.registerLazySingleton<PostsLocalDataSource>(() => PostsLocalDataSourceImp(sharedprefrences: sl()),);


                  
 
                   
   sl.registerLazySingleton<http.Client>(() =>http.Client() );
 
 
 

 sl.registerFactory<PostsBloc>(() => PostsBloc(getpostUsesCase: sl()));

  
 
    
 
}
  }
