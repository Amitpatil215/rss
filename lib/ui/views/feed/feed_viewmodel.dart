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
      .withConverter<PostsModel>(
        fromFirestore: (snapshot, _) => PostsModel.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      );
  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.createPost,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
