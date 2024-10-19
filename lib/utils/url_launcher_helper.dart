import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<bool> launchWhatsApp({
    required String phoneNumber,
    required String message,
  }) async {
    final whatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    try {
      await launchUrl(whatsappUrl);
      return true;
    } catch (er) {
      debugPrint(er.toString());
      return false;
    }
  }

  static Future<bool> launchPhone({
    required String phoneNumber,
  }) async {
    final phoneUrl = Uri.parse("tel:$phoneNumber");
    try {
      await launchUrl(phoneUrl);
      return true;
    } catch (er) {
      debugPrint(er.toString());
      return false;
    }
  }

  static Future<bool> launchEmail({
    required String email,
    required String subject,
    required String body,
  }) async {
    final emailUrl = Uri.parse(
        "mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}");
    try {
      await launchUrl(emailUrl);
      return true;
    } catch (er) {
      debugPrint(er.toString());
      return false;
    }
  }

  static Future<bool> launchToThisUrl(Uri url) async {
    try {
      await launchUrl(url);
      return true;
    } catch (er) {
      debugPrint(er.toString());
      return false;
    }
  }
}
