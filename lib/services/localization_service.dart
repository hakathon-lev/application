import 'dart:convert';
import 'package:flutter/services.dart';

class LocalizationService {
  static Map<String, String>? _localizedStrings;

  static Future<void> load(String languageCode) async {
    final String jsonString =
        await rootBundle.loadString('assets/lang/$languageCode.json');
    _localizedStrings = Map<String, String>.from(json.decode(jsonString));
  }

  static String translate(String key) {
    return _localizedStrings?[key] ?? key;
  }
}
