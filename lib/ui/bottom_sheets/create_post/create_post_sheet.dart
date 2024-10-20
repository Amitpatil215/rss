import 'package:flutter/material.dart';
import 'package:rss/ui/common/ui_helpers.dart';
import 'package:rss/utils/widgets/next_gen_button/next_gen_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../common/app_text_theme.dart';
import '../../../utils/input_decorations.dart';
import 'create_post_sheet_model.dart';

class CreatePostSheet extends StackedView<CreatePostSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CreatePostSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreatePostSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add a new post!!',
              style: AppTextStyles.h6,
            ),
            verticalSpaceMedium,
            Form(
                child: Column(
              children: [
                TextFormField(
                  minLines: 4,
                  maxLines: 8,
                  controller: viewModel.textController,
                  decoration: NGFieldInputDecorations.formFieldInputDecoration(
                          context: context, labelText: "Text")
                      .copyWith(),
                ),
                verticalSpaceMedium,
                JJMainCallToActionButtonWeb(
                  onPressed: viewModel.createPost,
                  width: double.infinity,
                  text: "Create",
                  bgColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                )
              ],
            )),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  @override
  CreatePostSheetModel viewModelBuilder(BuildContext context) =>
      CreatePostSheetModel();
}
