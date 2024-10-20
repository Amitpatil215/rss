import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rss/model/posts.dart';
import 'package:rss/model/response_model/chatgpt_response.dart';
import 'package:rss/repository/api_calls.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../utils/util_functions.dart';

class CreatePostSheetModel extends BaseViewModel {
  TextEditingController textController = TextEditingController();
  final _bottomSheetService = locator<BottomSheetService>();
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
                type: formattedTask.type,
                createdAt: DateTime.now(),
                lastSeen: DateTime.now(),
                status: "pending",
                dueDate: parseDate(formattedTask.dueDate))
            .toJson());

        _bottomSheetService.completeSheet(SheetResponse());
      }
    }
  }
}


