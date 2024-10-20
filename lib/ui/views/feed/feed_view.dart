import 'package:any_link_preview/any_link_preview.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:rss/common/app_text_theme.dart';
import 'package:rss/model/posts.dart';
import 'package:rss/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'feed_viewmodel.dart';

class FeedView extends StackedView<FeedViewModel> {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FeedViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.93),
      body: Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            verticalSpaceSmall,
            Text(
              "Spaced Repetition",
              style: AppTextStyles.h2,
            ),
            verticalSpaceSmall,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    filterValue: FilterBy.VIDEO,
                    onTap: (p0) {
                      viewModel.applyFilter(FilterBy.VIDEO);
                    },
                    isSelected: viewModel.isSelected(FilterBy.VIDEO),
                  ),
                  FilterChip(
                    filterValue: FilterBy.TASK,
                    onTap: (p0) {
                      viewModel.applyFilter(FilterBy.TASK);
                    },
                    isSelected: viewModel.isSelected(FilterBy.TASK),
                  ),
                  FilterChip(
                    filterValue: FilterBy.PENDING,
                    onTap: (p0) {
                      viewModel.applyFilter(FilterBy.PENDING);
                    },
                    isSelected: viewModel.isSelected(FilterBy.PENDING),
                  ),
                  FilterChip(
                    filterValue: FilterBy.COMPLETED,
                    onTap: (p0) {
                      viewModel.applyFilter(FilterBy.COMPLETED);
                    },
                    isSelected: viewModel.isSelected(FilterBy.COMPLETED),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FirestoreListView<PostsModel>(
                pageSize: 15,
                query: viewModel.getQuery(),
                itemBuilder: (context, snapshot) {
                  PostsModel postModel = snapshot.data();
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: ValueKey(postModel.id),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),
                        dragDismissible: false,
                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (context) =>
                                viewModel.priortiseTask(postModel),
                            backgroundColor: Colors.purpleAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.bolt_rounded,
                            label: 'Priortise',
                          ),
                          SlidableAction(
                            onPressed: (s) => viewModel.completeTask(postModel),
                            backgroundColor: Colors.greenAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.check,
                            label: 'Complete',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (s) =>
                                viewModel.updateLastSeen(postModel),
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            icon: Icons.spa_rounded,
                            label: 'Seen',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (postModel.url != null) ...[
                                    AnyLinkPreview(
                                      removeElevation: true,
                                      previewHeight:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      link: postModel.url!,
                                      cache: const Duration(hours: 5),
                                      borderRadius: 10,
                                      backgroundColor: Colors.white,
                                      errorWidget: Container(
                                        color: Colors.white,
                                        child:
                                            const Text("Couldn't get preview"),
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 0.1,
                                    ),
                                  ],
                                  if (postModel.url == null) ...[
                                    verticalSpaceSmall,
                                  ],
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: GestureDetector(
                                      onLongPress: () =>
                                          viewModel.openEditSheet(postModel),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (postModel.url != null)
                                                  const Icon(
                                                      Icons.video_label_rounded,
                                                      size: 15),
                                                if (postModel.url == null)
                                                  const Icon(
                                                      Icons
                                                          .track_changes_outlined,
                                                      size: 15),
                                                horizontalSpaceTiny,
                                                Expanded(
                                                  child: ReadMoreText(
                                                    postModel.text ?? '',
                                                    trimMode: TrimMode.Line,
                                                    trimLines: 3,
                                                    colorClickableText:
                                                        Colors.pink,
                                                    trimCollapsedText:
                                                        'Show more',
                                                    trimExpandedText:
                                                        ' Show less',
                                                    style: AppTextStyles.h6,
                                                    moreStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => viewModel
                                                      .openCommentSheet(
                                                          postModel),
                                                  child: Row(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(3.0),
                                                        child: Icon(
                                                          Icons
                                                              .comment_outlined,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        (postModel.commentCount ??
                                                                0)
                                                            .toString(),
                                                        style: AppTextStyles
                                                            .bodyText1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ReadMoreText(
                                              postModel.desc ?? '',
                                              trimMode: TrimMode.Line,
                                              trimLines: 3,
                                              colorClickableText: Colors.pink,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: ' Show less',
                                              style: AppTextStyles.bodyText1,
                                              moreStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            verticalSpaceTiny,
                                            Row(
                                              children: [
                                                Text(
                                                  "${DateFormat('dd MMM, hh:mm a').format(
                                                    postModel.lastSeen ??
                                                        DateTime.now(),
                                                  )} |",
                                                  style: AppTextStyles.caption,
                                                ),
                                                horizontalSpaceTiny,
                                                Text(
                                                  "Due on ${DateFormat('dd MMM').format(
                                                    postModel.dueDate ??
                                                        DateTime.now(),
                                                  )} |",
                                                  style: AppTextStyles.caption,
                                                ),
                                                horizontalSpaceTiny,
                                                Text(
                                                  "Created on ${DateFormat('dd MMM').format(
                                                    postModel.createdAt ??
                                                        DateTime.now(),
                                                  )}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles.caption,
                                                ),
                                              ],
                                            ),
                                            verticalSpaceSmall,
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showBottomSheet,
        child: const Icon(Icons.add_card_rounded),
      ),
    );
  }

  @override
  FeedViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FeedViewModel();
}

class FilterChip extends StatelessWidget {
  final bool isSelected;
  final FilterBy filterValue;
  //callback
  final Function(FilterBy) onTap;
  const FilterChip({
    super.key,
    this.isSelected = false,
    required this.filterValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () => onTap(filterValue),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.purpleAccent.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            filterValue.name,
            style: AppTextStyles.bodyText1.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
