import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rss/model/posts.dart';
import 'package:stacked/stacked.dart';

class CreatePostSheetModel extends BaseViewModel {
  TextEditingController textController = TextEditingController();
  void createPost() {
    if (textController.text.isNotEmpty) {
      print(textController.text);
      FirebaseFirestore.instance.collection('posts').add(PostsModel(
              text: textController.text,
              id: null,
              url: "https://google.com",
              createdAt: DateTime.now(),
              lastSeen: DateTime.now(),
              status: "pending",
              dueDate: DateTime.now())
          .toJson());
    }
  }
}
