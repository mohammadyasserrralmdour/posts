import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/domain/usescaes/addPostUsesCase.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/add_delete_update/add_delete_update_dart_bloc.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/home_screen.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/widget/CustomTextfield.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';


class DeleteUpdateScreen extends StatefulWidget {
  final Post post;
  const DeleteUpdateScreen({super.key, required this.post});

  @override
  State<DeleteUpdateScreen> createState() => _DeleteUpdateScreenState();
}

class _DeleteUpdateScreenState extends State<DeleteUpdateScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  @override
  void initState() {
    super.initState();
    title.text = widget.post.title!;
    body.text = widget.post.body!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 11, 66, 111),
        title: const Text(
          'Upgrade Delete',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child:
              BlocListener<AddDeleteUpdateDartBloc, AddDeleteUpdateDartState>(
            listener: (context, state) async {
              if (state is Loading) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 11, 66, 111),)),
                );
              } else if (state is Success) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                          ,borderRadius: BorderRadius.circular(20)),
                        padding:
                        const    EdgeInsets.symmetric(vertical: 40, horizontal: 60),
                        child:const Text(
                          "Success",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color:  Color.fromARGB(255, 11, 66, 111),),
                        )),
                  ),
                );
                 RefreshHome.onRefresh(context);
                await Future.delayed(const Duration(seconds: 2));
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else if (state is Error) {
                Center(
                  child: Text("erorr"),
                );
              }
            },
            child: buildListview(),
          )
         
          ),
    );
  }

  Widget buildListview() {
    return ListView(
      children: [
        CustomTextField(
          controller: title,
          hint: null,
          maxLines: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(controller: body, maxLines: 6, hint: null),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  Post post = Post(
                      userId: 1,
                      body: body.text,
                      id: widget.post.id,
                      title: title.text);
                      DependecnyInjection.sl<Logger>().i("===============Screen===============");
                  BlocProvider.of<AddDeleteUpdateDartBloc>(context)
                      .add(UpdatePostsEvent(post: post));
                },
                child: const Row(
                  children: [Icon(Icons.edit), Text("edit")],
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Post post = Post(
                      userId: 1,
                      body: body.text,
                      id: widget.post.id,
                      title: title.text);
                  BlocProvider.of<AddDeleteUpdateDartBloc>(context)
                      .add(DeletePostsEvent(id: post.id!));
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text(
                      "delete",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
          ],
        )
      ],
    );
  }
}
