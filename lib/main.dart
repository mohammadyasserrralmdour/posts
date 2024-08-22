import 'package:clean_architecture/features/Posts/presentation/logic/add_delete_update/add_delete_update_dart_bloc.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/bloc/posts_bloc.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/home_screen.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:http/http.dart'  as http ;






void main()async {
  WidgetsFlutterBinding.ensureInitialized();
      DependecnyInjection.init();
  final  sharedPreferences=await SharedPreferences.getInstance();
 final client= await http.Client();
 

  runApp( MyApp(client: client,sharedPreferences: sharedPreferences,));
// runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final http.Client client;  
   const MyApp({super.key, required this.sharedPreferences, required this.client});
  // const MyApp({super.key,});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create:(_) => DependecnyInjection.sl<PostsBloc>() 
           //PostsBloc(postUsesCase: GetPostsUsesCase(postsRepo: PostRepoImp(remouteDataSource: PostsRemoteDataSourceImp(client: client), localDataSource: PostsLocalDataSourceImp(sharedprefrences:sharedPreferences ))))
       
       ..add(GetPostsEvent())
        ),
        BlocProvider(
          create: (_) => DependecnyInjection.sl<AddDeleteUpdateDartBloc>(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

