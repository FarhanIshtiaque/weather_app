
import 'package:flutter/material.dart';


import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';

ThemeData theme() {
  return ThemeData(
   useMaterial3: false,
    cardColor: AppColors.red600,
    fontFamily: 'Nunito',
    appBarTheme: appBarTheme(), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(surface: AppColors.white)

  );
}

AppBarTheme appBarTheme() {
  return  AppBarTheme(
    titleSpacing: 24,
    color: Colors.white,
    elevation: 0,
   // toolbarHeight: 70,
   // shadowColor: AppColors.gray50,
    centerTitle: true,

    iconTheme: const IconThemeData(
      color: AppColors.black,

    ),
    titleTextStyle: AppTextStyle.headingSmall.copyWith(color: AppColors.black),
  );
}
