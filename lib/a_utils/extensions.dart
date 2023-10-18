import 'package:get/get.dart';

extension Widths on num {
  double get s => (Get.width * this / 375);
}
