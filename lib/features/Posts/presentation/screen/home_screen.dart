import 'package:clean_architecture/core/widget/Customloading.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/bloc/posts_bloc.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/add_screen.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/widget/CustomListPosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const AddDeleteUpdateScreen();
              },
            ));
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 40),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => BlocProvider.of<PostsBloc>(context)
                  ..add(RefreshPostsEvent()),
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ))
          ],
          backgroundColor: const Color.fromARGB(255, 11, 66, 111),
          title: const Text(
            'Posts',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            RefreshHome.onRefresh(context);
          },
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if (state is PostsInitial) {
                    return Center(child: Text(state.init));
                  } else if (state is LoadingPost) {
                    return const CustomLoading();
                  } else if (state is Loaded) {
                    return CustomListPosts(posts: postscreen);
                  } else if (state is Erorr) {
                    return const Center(
                      child: Text("Erorr"),
                    );
                  } else {
                    return Container();
                  }
                },
              )),
        ));
  }
}

class  RefreshHome {
  static Future<void> onRefresh(BuildContext context) async {
  await BlocProvider.of<PostsBloc>(context)
    ..add(RefreshPostsEvent());
  return Future.value();
}
}


