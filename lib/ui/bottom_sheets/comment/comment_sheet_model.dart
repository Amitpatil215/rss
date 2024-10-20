import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rss/model/comment.dart';
import 'package:rss/model/posts.dart';
import 'package:stacked/stacked.dart';

class CommentSheetModel extends BaseViewModel {
  TextEditingController textController = TextEditingController();
  Query<CommentModel> getCommentQuery(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('created_at', descending: true)
        .withConverter<CommentModel>(
          fromFirestore: (snapshot, _) =>
              CommentModel.fromJson(snapshot.data()!, snapshot.reference.id),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  void sendMessage(PostsModel post) async {
    final postId = post.id;
    if (postId == null) {
      return;
    }
    if (textController.text.isNotEmpty) {
      try {
        final batch = await FirebaseFirestore.instance.batch();
        final commentRef = FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc();
        final postRef =
            FirebaseFirestore.instance.collection("posts").doc(postId);
        batch.set(
            commentRef,
            CommentModel(
              text: textController.text,
              id: null,
              createdAt: DateTime.now(),
            ).toJsonNoNull());
        batch.update(
          postRef,
          {
            'comment_count': FieldValue.increment(1),
          },
        );
        await batch.commit();
        textController.clear();
      } catch (er) {
        print(er);
      }
    }
  }
}
