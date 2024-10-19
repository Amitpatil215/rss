import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../common/app_strings.dart';

class FeedViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.createPost,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
