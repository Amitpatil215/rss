import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rss/model/comment.dart';
import 'package:rss/ui/common/app_colors.dart';
import 'package:rss/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/posts.dart';
import '../../../utils/input_decorations.dart';
import 'comment_sheet_model.dart';

class CommentSheet extends StackedView<CommentSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const CommentSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CommentSheetModel viewModel,
    Widget? child,
  ) {
    var post = request.data as PostsModel;

    // Sample messages for demonstration
    List<String> messages = ['Hello!', 'How can I help you today?', 'Goodbye!'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          // Chat Area
          if (post.id != null)
            Expanded(
              child: FirestoreListView(
                reverse: true,
                pageSize: 10,
                query: viewModel.getCommentQuery(post.id!),
                itemBuilder: (context, snapshot) {
                  CommentModel comment = snapshot.data();

                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        comment.text ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          // Input text field with send button
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: viewModel.textController,
                    decoration:
                        NGFieldInputDecorations.formFieldInputDecoration(
                            context: context, labelText: "Type your comment.."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () => viewModel.sendMessage(post),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  CommentSheetModel viewModelBuilder(BuildContext context) =>
      CommentSheetModel();
}
