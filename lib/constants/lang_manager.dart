// import 'dart:convert';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCashHelper {
  // get save value
  Future<void> cashLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("LOCALE", languageCode);
  }

  // save value after select
  Future<String> getCashedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final cashedLanguageCode = prefs.getString("LOCALE");
    if (cashedLanguageCode != null) {
      return cashedLanguageCode;
    } else {
      return "en";
    }
  }
}
