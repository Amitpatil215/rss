import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rss/model/posts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../common/app_strings.dart';

class FeedViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();

  final postsQuery = FirebaseFirestore.instance
      .collection('posts')
      .where('status', isEqualTo: 'pending')
      .orderBy('due_date', descending: false)
      .orderBy('last_seen', descending: false)
      .withConverter<PostsModel>(
        fromFirestore: (snapshot, _) =>
            PostsModel.fromJson(snapshot.data()!, snapshot.reference.id),
        toFirestore: (post, _) => post.toJson(),
      );

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.createPost,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  void completeTask(PostsModel post) async {
    await FirebaseFirestore.instance.collection('posts').doc(post.id).update(
          PostsModel(
            status: 'completed',
            lastSeen: DateTime.now(),
          ).toJsonNoNull(),
        );
  }

  Future updateLastSeen(PostsModel post) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .update(PostsModel(lastSeen: DateTime.now()).toJsonNoNull());
  }
}
