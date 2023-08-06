import 'package:e_commerce_app/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConestants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

//regular style
TextStyle getRegularStyle({double fontSize = 12.0, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

//medium style
TextStyle getMediumStyle({double fontSize = 12.0, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

//light style
TextStyle getLightStyle({double fontSize = 12.0, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

//bold style
TextStyle getBoldStyle({double fontSize = 12.0, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

//semiBold style
TextStyle getSemiBoldStyle({double fontSize = 12.0, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
