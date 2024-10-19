import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_theme.dart';
import 'next_gen_button_options.dart';

class JJMainCallToActionButtonWeb extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final double? width;
  final Widget? icon;
  final bool isTransparent;
  final TextStyle? textStyle;
  final Color bgColor;
  const JJMainCallToActionButtonWeb({
    required this.onPressed,
    this.text,
    this.width,
    this.icon,
    this.isTransparent = false,
    this.textStyle,
    this.bgColor = AppColors.kcGreenColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 43.0,
      decoration: isTransparent
          ? null
          : BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
      child: NGButtonWidget(
        onPressed: onPressed,
        text: text ?? "",
        icon: icon,
        options: NextGenButtonOptions(
          color: const Color(0x004B39EF),
          disabledColor:
              isTransparent ? Colors.transparent : Colors.green.shade200,
          textStyle: textStyle ??
              AppTextStyles.bodyText1.copyWith(
                color: Colors.white,
              ),
          elevation: 0.0,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}

class JJSecondaryCallToActionButtonWeb extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final double? width;
  final Widget? icon;
  final NextGenButtonOptions? ngButtonOptions;
  const JJSecondaryCallToActionButtonWeb({
    required this.onPressed,
    this.text,
    this.width,
    this.icon,
    this.ngButtonOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 43.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: NGButtonWidget(
        onPressed: onPressed,
        text: text ?? "",
        icon: icon,
        options: NextGenButtonOptions(
          color: Colors.grey[300],
          disabledColor: const Color(0xFFb7afd0),
          textStyle: AppTextStyles.bodyText1.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          elevation: 0.0,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ).merge(ngButtonOptions),
      ),
    );
  }
}

class JJOutlinedCallToActionButtonWeb extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final double? width;
  final double? height;
  final Icon? icon;
  final NextGenButtonOptions? ngButtonOptions;
  const JJOutlinedCallToActionButtonWeb({
    required this.onPressed,
    this.text,
    this.height,
    this.width,
    this.icon,
    this.ngButtonOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: NGButtonWidget(
        onPressed: onPressed,
        text: text ?? "",
        icon: icon,
        options: ngButtonOptions ??
            NextGenButtonOptions(
              color: Colors.transparent,
              disabledColor: Colors.transparent,
              textStyle: AppTextStyles.bodyText1.copyWith(
                color: AppColors.kcBlueColor,
                fontWeight: FontWeight.w600,
              ),
              iconSize: icon?.size,
              elevation: 0.0,
              borderSide: const BorderSide(
                color: AppColors.kcWhiteColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
      ),
    );
  }
}

class JJIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Duration? debounceDuration;
  final Widget? icon;
  final String? tooltipmessage;
  final double? width;
  final String? text;
  const JJIconButton({
    required this.onPressed,
    this.icon,
    this.text,
    this.debounceDuration,
    this.tooltipmessage,
    this.width = 35,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Tooltip(
        message: tooltipmessage ?? "",
        child: NGButtonWidget(
          onPressed: onPressed,
          text: text ?? '',
          icon: icon,
          options: NextGenButtonOptions(
            debounceDuration: debounceDuration,
            width: width,
            padding: EdgeInsets.zero,
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            textStyle: AppTextStyles.bodyText1.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            elevation: 0.0,
          ),
        ),
      ),
    );
  }
}
