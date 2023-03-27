import 'package:flutter/cupertino.dart';

extension SizeExtention on num {
  SizedBox height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  SizedBox width() {
    return SizedBox(
      width: toDouble(),
    );
  }
}