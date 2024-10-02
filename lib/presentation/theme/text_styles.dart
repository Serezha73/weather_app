import 'package:flutter/material.dart';
import 'colors_app.dart';
import 'sizes_app.dart';

class AppTextStyles {
  static const TextStyle whiteText = TextStyle(
    fontSize: AppSizes.fontMedium,
    color: AppColors.whiteText,
  );

  static const TextStyle greyText = TextStyle(
    fontSize: AppSizes.fontMedium,
    color: AppColors.greyText,
  );

  static const TextStyle titleText = TextStyle(
    fontSize: AppSizes.fontTitle,
    color: AppColors.whiteText,
    fontWeight: FontWeight.bold,
  );
}
