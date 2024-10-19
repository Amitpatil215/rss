import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:rss/common/app_text_theme.dart';
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnyLinkPreview(
                          removeElevation: true,
                          link: "https://youtu.be/watch?v=W1pNjxmNHNQ",
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
                              left: 10, right: 10, bottom: 10),
                          child: const ReadMoreText(
                            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                            trimMode: TrimMode.Line,
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
        child: Icon(Icons.add_card_rounded),
      ),
    );
  }

  @override
  FeedViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FeedViewModel();
}
