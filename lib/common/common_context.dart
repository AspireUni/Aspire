import 'package:flutter/material.dart';

class CommonContext {
  void init(BuildContext context) {
    ScreenSize().init(context);
    ThemeColors().init(context);
  }
}
class ScreenSize {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    
    _safeAreaHorizontal = _mediaQueryData.padding.left + 
    _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
    _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth -
    _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight -
    _safeAreaVertical) / 100;
  }
}

class ThemeColors {
  static var primaryColor;
  static var accentColor;

  void init(BuildContext context) {
    primaryColor = Color(0xFF0F1236);
    accentColor = Color(0xFF45cab9); 
  }
}
