import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rss/app/app.bottomsheets.dart';
import 'package:rss/app/app.dialogs.dart';
import 'package:rss/app/app.locator.dart';
import 'package:rss/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void incrementCounter() async {
    await FirebaseFirestore.instance.collection('user').add(
      {'Name': 'Abhishek', 'Mobile': '1234', 'Email': 'z2N7z@example.com'},
    );
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
