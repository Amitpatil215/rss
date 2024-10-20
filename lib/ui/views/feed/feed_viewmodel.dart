import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rss/model/posts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../common/app_strings.dart';

enum FilterBy { VIDEO, TASK, PENDING, COMPLETED }

class FeedViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();

  // final postsQuery = FirebaseFirestore.instance
  //     .collection('posts')
  //     .where('status', isEqualTo: 'pending')
  //     .orderBy('due_date', descending: false)
  //     .orderBy('last_seen', descending: false)
  //     .withConverter<PostsModel>(
  //       fromFirestore: (snapshot, _) =>
  //           PostsModel.fromJson(snapshot.data()!, snapshot.reference.id),
  //       toFirestore: (post, _) => post.toJson(),
  //     );
  Query<PostsModel> getQuery() {
    /// use filter by for writing the query
    var collectionRef = FirebaseFirestore.instance.collection('posts');
    Query<Map<String, dynamic>> newQuery = collectionRef;
    if (isSelected(FilterBy.PENDING)) {
      newQuery = newQuery.where('status', isEqualTo: 'pending');
    }
    if (isSelected(FilterBy.COMPLETED)) {
      newQuery = newQuery.where('status', isEqualTo: 'completed');
    }
    if (isSelected(FilterBy.VIDEO)) {
      newQuery = newQuery.where('type', isEqualTo: 'video');
    }
    if (isSelected(FilterBy.TASK)) {
      newQuery = newQuery.where('type', isEqualTo: 'task');
    }

    return newQuery
        .orderBy('due_date', descending: false)
        .orderBy('last_seen', descending: false)
        .withConverter<PostsModel>(
          fromFirestore: (snapshot, _) =>
              PostsModel.fromJson(snapshot.data()!, snapshot.reference.id),
          toFirestore: (post, _) => post.toJson(),
        );
  }

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

  Future priortiseTask(PostsModel post) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .update(PostsModel(
          status: 'pending',
          lastSeen: DateTime.now().subtract(const Duration(days: 30)),
        ).toJsonNoNull());
  }

  final List<FilterBy> _currentFilter = [FilterBy.PENDING];

  // apply filter
  void applyFilter(FilterBy filterBy) {
    // switch between pending and completed
    if (filterBy == FilterBy.PENDING) {
      _currentFilter.remove(FilterBy.COMPLETED);
    } else if (filterBy == FilterBy.COMPLETED) {
      _currentFilter.remove(FilterBy.PENDING);
    }

    /// Switch between video and task
    if (filterBy == FilterBy.VIDEO) {
      _currentFilter.remove(FilterBy.TASK);
    } else if (filterBy == FilterBy.TASK) {
      _currentFilter.remove(FilterBy.VIDEO);
    }

    if (isSelected(filterBy)) {
      _currentFilter.remove(filterBy);
    } else {
      _currentFilter.add(filterBy);
    }
    rebuildUi();
  }

  bool isSelected(FilterBy filterBy) {
    return _currentFilter.contains(filterBy);
  }

  // get current filter
  // getter
  List<FilterBy> get currentFilter => _currentFilter;

  void openEditSheet(PostsModel post) {
    _bottomSheetService.showCustomSheet<PostsModel, PostsModel>(
      variant: BottomSheetType.edit,
      data: post,
    );
  }
}
