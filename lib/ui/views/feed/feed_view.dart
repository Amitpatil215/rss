import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  FlutterLogo(),
                  verticalSpaceSmall,
                  Text('Title $index'),
                  verticalSpaceSmall,
                  Text('Description $index'),
                  verticalSpaceSmall,
                  Text('Date $index'),
                ],
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }

  @override
  FeedViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FeedViewModel();
}
