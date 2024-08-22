import 'dart:convert';

import 'package:clean_architecture/features/Posts/presentation/logic/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String? hint;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.maxLines,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    List<int> ids = postscreen
        .map<int>(
          (post) => post.id!,
        )
        .toList();
    return TextFormField(
      maxLines: maxLines,
      decoration:
          InputDecoration(hintText: hint, border: const OutlineInputBorder()),
      controller: controller,
      validator: (value) {
        if (value == null) {
          return "Cannt be Empty";
        }
        if (value.isEmpty) {
          return "Cannt be Empty";
        }
        
        // if (jsonDecode(value).runtimeType == int) {
        //   if (ids.contains(int.parse(value))) {
        //     return "already exits";
        //   }
        // }
      },
      
    );
  }
}
