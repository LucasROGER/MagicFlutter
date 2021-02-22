import 'package:flutter/cupertino.dart';

class ResponsiveSize {
  static double responsiveWidth(BuildContext context, double value) {
    return MediaQuery.of(context).size.width * value / 100;
  }

  static double responsiveHeight(BuildContext context, double value) {
    return MediaQuery.of(context).size.height * value / 100;
  }
}