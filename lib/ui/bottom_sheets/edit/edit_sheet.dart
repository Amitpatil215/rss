import 'package:flutter/material.dart';
import 'package:rss/model/posts.dart';
import 'package:rss/ui/common/app_colors.dart';
import 'package:rss/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'edit_sheet_model.dart';

class EditSheet extends StackedView<EditSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const EditSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditSheetModel viewModel,
    Widget? child,
  ) {
    var post = request.data as PostsModel;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            post.text ?? "",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceMedium,
          SelectableText(post.toString()),
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  EditSheetModel viewModelBuilder(BuildContext context) => EditSheetModel();
}
