import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s8 => 8 * scale;
  static double get s10 => 10 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s13 => 13 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s18 => 18 * scale;
  static double get s22 => 22 * scale;
  static double get s20 => 20 * scale;
  static double get s24 => 24 * scale;
  static double get s28 => 28 * scale;
  static double get s34 => 34 * scale;
  static double get s38 => 38 * scale;
}

class AppTextStyles {
  // Base style for Montserrat (Header & Titles)
  static TextStyle montserratStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    height: 1,
  );

  // Base style for Open Sans (General Text)
  static TextStyle openSansStyle = GoogleFonts.openSans(
    fontWeight: FontWeight.w400,
    height: 1,
  );

  // Header styles
  static TextStyle get h1 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s34,
        height: 1.17,
      );

  static TextStyle get h2 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s28,
        height: 1.2,
      );

  static TextStyle get h3 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s24,
        height: 1.25,
      );

  static TextStyle get h3OpenSans => openSansStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s24,
        height: 1.25,
      );

  static TextStyle get hM35 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s22,
        height: 1.35,
      );

  static TextStyle get h4 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s20,
        height: 1.3,
      );

  static TextStyle get h5 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s18,
        height: 1.35,
      );

  static TextStyle get h6 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s16,
        height: 1.4,
      );
  static TextStyle get h7 => montserratStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s14,
        height: 1.4,
      );

  static TextStyle get bodyText1M => montserratStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s13,
        height: 1.5,
      );

  static TextStyle get bodyText3M => montserratStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s12,
        height: 1.2,
      );

  static TextStyle get bodyText1 => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s13,
        height: 1.5,
      );

  static TextStyle get bodyText1H => openSansStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s14,
        height: 1.5,
      );

  static TextStyle get bodyText2 => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s12,
        height: 1.5,
      );

  static TextStyle get bodyText3 => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s12,
        height: 1.2,
      );

  static TextStyle get bodyText5 => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s8,
        height: 1,
      );

  static TextStyle get subtitle1 => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s16,
        height: 1.75,
      );

  static TextStyle get subtitle2 => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s14,
        height: 1.75,
      );

  static TextStyle get caption => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s12,
        height: 1.4,
      );

  static TextStyle get overline => openSansStyle.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s10,
        height: 1.4,
      );

  static TextStyle get button => openSansStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s14,
        height: 1.5,
      );
}
