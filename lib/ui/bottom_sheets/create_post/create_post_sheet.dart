import 'package:flutter/material.dart';
import 'package:rss/ui/common/app_colors.dart';
import 'package:rss/ui/common/ui_helpers.dart';
import 'package:rss/utils/widgets/next_gen_button/next_gen_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add a new post!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceTiny,
          Form(
              child: Column(
            children: [
              TextFormField(
                minLines: 2,
                maxLines: 6,
                // controller: viewModel.titleController,
                decoration: NGFieldInputDecorations.formFieldInputDecoration(
                        context: context, labelText: "Text")
                    .copyWith(),
              ),
              verticalSpaceMedium,
              JJMainCallToActionButtonWeb(
                onPressed: () {},
                width: double.infinity,
                text: "Create",
              )
            ],
          )),
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  CreatePostSheetModel viewModelBuilder(BuildContext context) =>
      CreatePostSheetModel();
}
