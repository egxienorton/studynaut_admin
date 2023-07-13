import 'package:flutter/material.dart';

class AppTypography {
  // static double _screenWidth;
  // static double _screenHeight;

  static double? _screenWidth = 0;
  static double? _screenHeight = 0;

  static void initialize(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;
  }

  static double _getResponsiveFontSize(double baseFontSize) {
    final screenWidthRatio =
        _screenWidth! / 375; // 375 is the reference screen width
    return baseFontSize * screenWidthRatio;
  }

  static TextStyle header1(BuildContext context) {
    final fontSize = _getResponsiveFontSize(32);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.bold,
      // letterSpacing: -1.5,
      letterSpacing: -1.5,
    );
  }

  static TextStyle header2(BuildContext context) {
    final fontSize = _getResponsiveFontSize(24);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    );
  }

  static TextStyle header3(BuildContext context) {
    final fontSize = _getResponsiveFontSize(20);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle header4(BuildContext context) {
    final fontSize = _getResponsiveFontSize(18);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
    );
  }

  static TextStyle header5(BuildContext context) {
    final fontSize = _getResponsiveFontSize(16);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle header6(BuildContext context) {
    final fontSize = _getResponsiveFontSize(14);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    );
  }

  static TextStyle subtitle(BuildContext context) {
    final fontSize = _getResponsiveFontSize(16);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.normal,
      letterSpacing: 0.15,
    );
  }

  static TextStyle bodyText(BuildContext context) {
    final fontSize = _getResponsiveFontSize(14);
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      fontFamily: 'Aspira',
      letterSpacing: 0.25,
    );
  }

  static TextStyle caption(BuildContext context) {
    final fontSize = _getResponsiveFontSize(12);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Aspira',
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
    );
  }

  static TextStyle button(BuildContext context) {
    final fontSize = _getResponsiveFontSize(14);
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Satoshis',
      fontWeight: FontWeight.bold,
      letterSpacing: 1.25,
    );
  }

  static Color smartColor(BuildContext context) {
    return Theme.of(context).hintColor.withOpacity(.2);
  }
}
