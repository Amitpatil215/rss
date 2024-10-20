import 'package:rss/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:rss/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:rss/ui/views/home/home_view.dart';
import 'package:rss/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:rss/ui/views/feed/feed_view.dart';
import 'package:rss/ui/bottom_sheets/create_post/create_post_sheet.dart';
import 'package:rss/ui/bottom_sheets/edit/edit_sheet.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: FeedView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: CreatePostSheet),
    StackedBottomsheet(classType: EditSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
