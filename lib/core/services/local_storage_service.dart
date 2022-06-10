import 'dart:convert';
import 'package:flutter/services.dart';

class LocalStorageService {
  Future readJson(String jsonFilePath) async {
    final String response = await rootBundle.loadString(jsonFilePath);
    final data = await jsonDecode(response);
    return data;
  }
}
