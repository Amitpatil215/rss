import 'dart:async';

import 'package:flutter/material.dart';

class NextGenButtonOptions {
  const NextGenButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
    this.hoverColor,
    this.hoverBorderSide,
    this.hoverTextColor,
    this.hoverElevation,
    this.maxLines,
    this.debounceDuration,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final int? maxLines;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? hoverColor;
  final BorderSide? hoverBorderSide;
  final Color? hoverTextColor;
  final double? hoverElevation;
  final Duration? debounceDuration;

  // copy with method
  NextGenButtonOptions copyWith({
    TextStyle? textStyle,
    double? elevation,
    double? height,
    double? width,
    EdgeInsetsGeometry? padding,
    Color? color,
    Color? disabledColor,
    Color? disabledTextColor,
    int? maxLines,
    Color? splashColor,
    double? iconSize,
    Color? iconColor,
    EdgeInsetsGeometry? iconPadding,
    BorderRadius? borderRadius,
    BorderSide? borderSide,
    Color? hoverColor,
    BorderSide? hoverBorderSide,
    Color? hoverTextColor,
    double? hoverElevation,
    Duration? debounceDuration,
  }) {
    return NextGenButtonOptions(
      textStyle: textStyle ?? this.textStyle,
      elevation: elevation ?? this.elevation,
      height: height ?? this.height,
      width: width ?? this.width,
      padding: padding ?? this.padding,
      color: color ?? this.color,
      disabledColor: disabledColor ?? this.disabledColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      maxLines: maxLines ?? this.maxLines,
      splashColor: splashColor ?? this.splashColor,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      iconPadding: iconPadding ?? this.iconPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      borderSide: borderSide ?? this.borderSide,
      hoverColor: hoverColor ?? this.hoverColor,
      hoverBorderSide: hoverBorderSide ?? this.hoverBorderSide,
      hoverTextColor: hoverTextColor ?? this.hoverTextColor,
      hoverElevation: hoverElevation ?? this.hoverElevation,
      debounceDuration: debounceDuration ?? this.debounceDuration,
    );
  }

  // merge method
  NextGenButtonOptions merge(NextGenButtonOptions? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      elevation: other.elevation,
      height: other.height,
      width: other.width,
      padding: other.padding,
      color: other.color,
      disabledColor: other.disabledColor,
      disabledTextColor: other.disabledTextColor,
      maxLines: other.maxLines,
      splashColor: other.splashColor,
      iconSize: other.iconSize,
      iconColor: other.iconColor,
      iconPadding: other.iconPadding,
      borderRadius: other.borderRadius,
      borderSide: other.borderSide,
      hoverColor: other.hoverColor,
      hoverBorderSide: other.hoverBorderSide,
      hoverTextColor: other.hoverTextColor,
      hoverElevation: other.hoverElevation,
      debounceDuration: other.debounceDuration,
    );
  }
}

///
/// Button by default has a debounce duration of 500ms
class NGButtonWidget extends StatefulWidget {
  const NGButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
    this.showLoadingIndicator = true,
  });

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final Function()? onPressed;
  final NextGenButtonOptions options;
  final bool showLoadingIndicator;

  @override
  State<NGButtonWidget> createState() => _NGButtonWidgetState();
}

class _NGButtonWidgetState extends State<NGButtonWidget> {
  bool loading = false;
  Timer? _debounceTimer;
  int get maxLines => widget.options.maxLines ?? 1;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleDebouncedOnPressed() async {
    if (loading) return;

    if (_debounceTimer?.isActive ?? false) {
      return; // If the timer is active, do not proceed
    }

    setState(() => loading = true);

    // Set the timer to block subsequent calls until after the debounce duration
    _debounceTimer = Timer(
      widget.options.debounceDuration ?? const Duration(milliseconds: 500),
      () {}, // The timer is only used to block subsequent calls
    );

    try {
      await widget.onPressed!();
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: SizedBox(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle!.color ?? Colors.white,
                ),
              ),
            ),
          )
        : Text(
            widget.text,
            style: widget.options.textStyle?.copyWith(
              color: widget.options.textStyle!.color,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.onPressed != null
        ? (widget.showLoadingIndicator
            ? _handleDebouncedOnPressed
            : () {
                if (_debounceTimer?.isActive ?? false) {
                  return; // If the timer is active, do not proceed
                }
                // Set the timer to block subsequent calls until after the debounce duration
                _debounceTimer = Timer(
                  widget.options.debounceDuration ??
                      const Duration(milliseconds: 500),
                  () {}, // The timer is only used to block subsequent calls
                );
                widget.onPressed!();
              })
        : null;

    ButtonStyle style = ButtonStyle(
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
        (states) {
          if (states.contains(WidgetState.hovered) &&
              widget.options.hoverBorderSide != null) {
            return RoundedRectangleBorder(
              borderRadius:
                  widget.options.borderRadius ?? BorderRadius.circular(8),
              side: widget.options.hoverBorderSide!,
            );
          }
          return RoundedRectangleBorder(
            borderRadius:
                widget.options.borderRadius ?? BorderRadius.circular(8),
            side: widget.options.borderSide ?? BorderSide.none,
          );
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.disabled) &&
              widget.options.disabledTextColor != null) {
            return widget.options.disabledTextColor;
          }
          if (states.contains(WidgetState.hovered) &&
              widget.options.hoverTextColor != null) {
            return widget.options.hoverTextColor;
          }
          return widget.options.textStyle?.color;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.disabled) &&
              widget.options.disabledColor != null) {
            return widget.options.disabledColor;
          }
          if (states.contains(WidgetState.hovered) &&
              widget.options.hoverColor != null) {
            return widget.options.hoverColor;
          }
          return widget.options.color;
        },
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return widget.options.splashColor;
        }
        return widget.options.hoverColor == null ? null : Colors.transparent;
      }),
      padding: WidgetStateProperty.all(widget.options.padding ??
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0)),
      elevation: WidgetStateProperty.resolveWith<double?>(
        (states) {
          if (states.contains(WidgetState.hovered) &&
              widget.options.hoverElevation != null) {
            return widget.options.hoverElevation!;
          }
          return widget.options.elevation;
        },
      ),
    );

    if ((widget.icon != null || widget.iconData != null) && !loading) {
      if (widget.text.isNotEmpty) {
        return SizedBox(
          height: widget.options.height,
          width: widget.options.width,
          child: ElevatedButton.icon(
            icon: Padding(
              padding: widget.options.iconPadding ?? EdgeInsets.zero,
              child: widget.icon ??
                  Icon(
                    widget.iconData,
                    size: widget.options.iconSize,
                    color: widget.options.iconColor ??
                        widget.options.textStyle!.color,
                  ),
            ),
            label: textWidget,
            onPressed: onPressed,
            style: style,
          ),
        );
      }
      if (widget.text.isEmpty) {
        return GestureDetector(
          onTap: onPressed,
          child: SizedBox(
            height: widget.options.height,
            width: widget.options.width,
            child: Padding(
              padding: widget.options.iconPadding ?? EdgeInsets.zero,
              child: widget.icon ??
                  Icon(
                    widget.iconData,
                    size: widget.options.iconSize,
                    color: widget.options.iconColor ??
                        widget.options.textStyle!.color,
                  ),
            ),
          ),
        );
      }
    }

    return SizedBox(
      height: widget.options.height,
      width: widget.options.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: textWidget,
      ),
    );
  }
}
