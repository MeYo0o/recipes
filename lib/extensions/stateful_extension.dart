import 'package:flutter/material.dart';

extension StatelessExtention on State {
  ThemeData extensionTheme(BuildContext context) {
    return Theme.of(context);
  }
}
