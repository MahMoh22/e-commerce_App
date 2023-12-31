import 'package:e_commerce_app/presentation/resources/color_manager.dart';
import 'package:e_commerce_app/presentation/resources/values_manager.dart';
import 'package:e_commerce_app/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

ThemeData themeManager() {
  return ThemeData(
      //main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.gray1,
      splashColor: ColorManager.lightPrimary,

      //CardView theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSizes.s4,
        shadowColor: ColorManager.gray,
      ),
      //AppBar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSizes.s4,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle:
            getRegularStyle(color: ColorManager.white, fontSize: AppSizes.s16),
      ),
      //Button theme
      buttonTheme: ButtonThemeData(
        disabledColor: ColorManager.gray1,
        shape: const StadiumBorder(),
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary,
      ),

//Elevated button them

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s12)),
        textStyle:
            getRegularStyle(color: ColorManager.white, fontSize: AppSizes.s17),
        backgroundColor: ColorManager.primary,
      )),
      //Text theme
      textTheme: TextTheme(
        displayLarge:
            getLightStyle(color: ColorManager.white, fontSize: AppSizes.s22),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.darkGray, fontSize: AppSizes.s16),
        headlineMedium: getRegularStyle(
            color: ColorManager.darkGray, fontSize: AppSizes.s14),
        headlineSmall:
            getBoldStyle(color: ColorManager.primary, fontSize: AppSizes.s12),
        titleLarge:
            getRegularStyle(color: ColorManager.white, fontSize: AppSizes.s16),
        titleMedium:
            getMediumStyle(color: ColorManager.primary, fontSize: AppSizes.s16),
        bodyLarge: getRegularStyle(color: ColorManager.gray1),
        bodySmall:
            getRegularStyle(color: ColorManager.gray2, fontSize: AppSizes.s12),
      ),
      //InputDecoration theme (TextFormField)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle:
            getRegularStyle(color: ColorManager.gray, fontSize: AppSizes.s14),
        labelStyle:
            getMediumStyle(color: ColorManager.gray, fontSize: AppSizes.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.gray, width: AppSizes.s1),
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSizes.s1),
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: AppSizes.s1),
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSizes.s1),
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
      ));
}
