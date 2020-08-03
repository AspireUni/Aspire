import 'package:flutter/material.dart';

class CommonContext {
  void init(BuildContext context) {
    ScreenSize().init(context);
    ThemeColors().init(context);
  }
}
class ScreenSize {
  static MediaQueryData _mediaQueryData;
  static double width;
  static double height;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    blockSizeHorizontal = width / 100;
    blockSizeVertical = height / 100;
    
    _safeAreaHorizontal = _mediaQueryData.padding.left + 
    _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
    _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (width -
    _safeAreaHorizontal) / 100;
    safeBlockVertical = (height -
    _safeAreaVertical) / 100;
  }
}

class ThemeColors {
  static var primary;
  static var accent;

  void init(BuildContext context) {
    primary = Color(0xFF0F1236);
    accent = Color(0xFF45cab9); 
  }
}
