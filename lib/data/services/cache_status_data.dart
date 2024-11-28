import 'dart:convert';

import '../model/status_text_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoacalStatusData {
  static Future<void> saveData(StatusTextModel textModel) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(textModel.toJson());
    await prefs.setString('text_model', data);
  }

  static Future<StatusTextModel?> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString('text_model');
    if (data != null) {
      final mapData = jsonDecode(data);
      return StatusTextModel.fromJson(mapData);
    } else {
      return null;
    }
  }
}
