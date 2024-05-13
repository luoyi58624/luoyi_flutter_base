import '../global.dart';

class GlobalController extends GetxController {
  static GlobalController get of => Get.find();
  final showPerformanceOverlay = false.obs;
  final Rx<String?> fontFamily = null.obs;
  final RxMap<String, String> locale = {
    '中文': 'zh',
    'English': 'en',
  }.obs;

}
