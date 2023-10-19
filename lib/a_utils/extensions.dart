import 'package:flutter/widgets.dart';

extension Widths on num {
  double get s => (screenSize.width * this / 375);
}

//
Size screenSize = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.first)
    .size;
