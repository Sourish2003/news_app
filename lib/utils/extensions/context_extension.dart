import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext{
  Size get screenSize => MediaQuery.of(this).size;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}