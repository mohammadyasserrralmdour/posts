import 'package:clean_architecture/features/Posts/domain/entity/post_entity.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/add_delete_update/add_delete_update_dart_bloc.dart';
import 'package:clean_architecture/features/Posts/presentation/logic/bloc/posts_bloc.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/home_screen.dart';
import 'package:clean_architecture/features/Posts/presentation/screen/widget/CustomTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDeleteUpdateScreen extends StatefulWidget {
  const AddDeleteUpdateScreen({super.key});

  @override
  State<AddDeleteUpdateScreen> createState() => _HomePageState();
}

class _HomePageState extends State<AddDeleteUpdateScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController body;
  late TextEditingController id;

  @override
  void initState() {
    title = TextEditingController();
    body = TextEditingController();
    id = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 66, 111),
          title: const Text(
            'Add  Post',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Form(
            key: formstate,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: BlocListener<AddDeleteUpdateDartBloc,
                  AddDeleteUpdateDartState>(
                listener: (context, state) async {
                  if (state is Loading) {
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 11, 66, 111),
                      )),
                    );
                  } else if (state is Success) {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 60),
                            child: const Text(
                              "Success",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color.fromARGB(255, 11, 66, 111),
                              ),
                            )),
                      ),
                    );
                    RefreshHome.onRefresh(context);
                    await Future.delayed(const Duration(seconds: 2));
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  } else if (state is Erorr) {
                    const Center(
                      child: Text("erorr"),
                    );
                  }
                },
                child: ListView(
                  children: [
                    CustomTextField(
                      controller: title,
                      maxLines: 1,
                      hint: "Enter title Post",
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: id,
                      maxLines: 1,
                      hint: "Enter id Post",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: body,
                      maxLines: 6,
                      hint: "Enter body Post",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bool x = formstate.currentState!.validate();
                          if (x) {
                            Post post = Post(
                                userId: 1,
                                body: body.text,
                                id: int.parse(id.text),
                                title: title.text);

                            context
                                .read<AddDeleteUpdateDartBloc>()
                                .add(AddPostsEvent(post: post));
                            //  BlocProvider.of<AddDeleteUpdateDartBloc>(context)..add(AddPostsEvent(post: post));
                          }
                        },
                        child: const Text("Add Post"))
                  ],
                ),
              ),
            )));
  }
}
