import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreatePostSheetModel extends BaseViewModel {
  TextEditingController textController = TextEditingController();
  void createPost() {
    if (textController.text.isNotEmpty) {
      print(textController.text);
      FirebaseFirestore.instance.collection('posts').add(
        {
          'text': textController.text,
          'url': "https://google.com",
          'created_at': FieldValue.serverTimestamp(),
          'last_seen': FieldValue.serverTimestamp(),
          'status': 'pending', //Pending, Completed, Snoozed
          'due_date': FieldValue.serverTimestamp(),
        },
      );
    }
  }
}
