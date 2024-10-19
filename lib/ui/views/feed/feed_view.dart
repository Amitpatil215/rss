import 'package:any_link_preview/any_link_preview.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:rss/common/app_text_theme.dart';
import 'package:rss/model/posts.dart';
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
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < 15; i++)
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Chip(
                          label: Text(
                        "Video",
                        style: TextStyle(color: Colors.black),
                      )),
                    )
                ],
              ),
            ),
            Expanded(
              child: FirestoreListView<PostsModel>(
                pageSize: 2,
                query: viewModel.postsQuery,
                itemBuilder: (context, snapshot) {
                  PostsModel postModel = snapshot.data();

                  return Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: ValueKey(postModel.id),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: (s) {},
                          backgroundColor: Colors.purpleAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.alarm,
                          label: 'Snooze',
                        ),
                        SlidableAction(
                          onPressed: (s) {},
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
                          onPressed: (s) {},
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          icon: Icons.date_range,
                          label: 'Change Date',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (postModel.url != null)
                                  AnyLinkPreview(
                                    removeElevation: true,
                                    link: postModel.url!,
                                    bodyMaxLines: 2,
                                    cache: const Duration(hours: 5),
                                    borderRadius: 10,
                                    backgroundColor: Colors.white,
                                    errorWidget: Container(
                                      color: Colors.white,
                                      child: const Text('Oops!'),
                                    ),
                                  ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10, top: 10),
                                  child: ReadMoreText(
                                    postModel.text ?? '',
                                    trimMode: TrimMode.Line,
                                    trimLines: 3,
                                    colorClickableText: Colors.pink,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: ' Show less',
                                    style: AppTextStyles.bodyText1H,
                                    moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: ReadMoreText(
                                    postModel.desc ?? '',
                                    trimMode: TrimMode.Line,
                                    trimLines: 3,
                                    colorClickableText: Colors.pink,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: ' Show less',
                                    style: AppTextStyles.bodyText2,
                                    moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    DateFormat('dd-MM-yyyy').format(
                                      postModel.dueDate ?? DateTime.now(),
                                    ),
                                    style: AppTextStyles.caption,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
