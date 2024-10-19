import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rss/model/posts.dart';
import 'package:rss/model/response_model/chatgpt_response.dart';
import 'package:rss/repository/api_calls.dart';
import 'package:stacked/stacked.dart';

class CreatePostSheetModel extends BaseViewModel {
  TextEditingController textController = TextEditingController();
  void createPost() async {
    if (textController.text.isNotEmpty) {
      print(textController.text);

      TaskResponse? formattedTask = await APICalls.getFormattedTasks(
        textController.text,
      );
      if (formattedTask != null) {
        print(formattedTask);

        await FirebaseFirestore.instance.collection('posts').add(PostsModel(
                text: formattedTask.title,
                desc: formattedTask.desc,
                id: null,
                url: formattedTask.url,
                createdAt: DateTime.now(),
                lastSeen: DateTime.now(),
                status: "pending",
                dueDate: parseDate(formattedTask.dueDate))
            .toJson());
      }
    }
  }
}

DateTime parseDate(String? data) {
  if (data == null) {
    return DateTime.now();
  }

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  // Parse the string to a DateTime object
  DateTime parsedDate = dateFormat.parse(data);

  return parsedDate;
}
