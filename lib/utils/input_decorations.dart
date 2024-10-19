import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/app_text_theme.dart';

class NGFieldInputDecorations {
  static double borderRadius = kIsWeb ? 4 : 8;

  static InputDecoration formFieldInputDecoration({
    required BuildContext context,
    required String labelText,
    String? hintText,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      fillColor: Colors.white,
      filled: kIsWeb ? false : true,
      floatingLabelStyle:
          AppTextStyles.bodyText1.copyWith(color: AppColors.kcBlackColor),
      contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      enabledBorder: enabledOutlineInputBorder(),
      disabledBorder: disabledOutlineInputBorder(),
      focusedBorder: focusedOutlineInputBorder(),
      focusedErrorBorder: focusedErrorBorder(),
      errorBorder: errorBorder(),
      labelText: labelText,
      errorStyle: errorTextFieldStyle(),
      labelStyle: AppTextStyles.bodyText1
        ..copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(255, 88, 85, 93),
        ),
      hoverColor: Colors.black,
      hintStyle: AppTextStyles.bodyText1,
    );
  }

  static OutlineInputBorder focusedErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: kIsWeb
            ? AppColors.kcRedColor.withOpacity(0.5)
            : const Color(0xFFEDEBF4),
      ),
    );
  }

  static OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(
        color: kIsWeb ? AppColors.kcRedColor : Color(0xFFEDEBF4),
      ),
    );
  }

  static OutlineInputBorder focusedOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(
        color: kIsWeb ? AppColors.kcBlueColor : Color(0xFFEDEBF4),
      ),
    );
  }

  static OutlineInputBorder enabledOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(
        color: kIsWeb ? AppColors.kcGreyColor : Color(0xFFEDEBF4),
      ),
    );
  }

  static OutlineInputBorder disabledOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: kIsWeb
            ? AppColors.kcRedColor.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
      ),
    );
  }

  static TextStyle errorTextFieldStyle() {
    return AppTextStyles.bodyText1.copyWith(
      color: AppColors.kcRedColor,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
  }
}
