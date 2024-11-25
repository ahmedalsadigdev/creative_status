// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class StatusTextModel {
  late String text;
  late Color fillColor;
  late TextAlign textAlign;
  late TextDirection textDirection;
  late TextStyle textStyle;
  StatusTextModel({
    required this.text,
    required this.fillColor,
    required this.textAlign,
    required this.textDirection,
    required this.textStyle,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'fillColor': fillColor.value,
      'textAlign': textAlign.toString(),
      'textDirection': textDirection.toString(),
      'textStyle': serializeTextStyle(textStyle),
    };
  }

  StatusTextModel.fromJson(Map<String, dynamic> Json) {
    text = Json['text'];
    fillColor = Color(Json['fillColor']);
    textAlign = TextAlign.values.firstWhere(
      (e) => e.toString() == Json['textAlign'],
      orElse: () => TextAlign.left,
    );
    textDirection = TextDirection.values.firstWhere(
      (e) => e.toString() == Json['textDirection'],
      orElse: () => TextDirection.ltr,
    );
    textStyle = deserializeTextStyle(Json['textStyle']);
  }

  /// Serialize `TextStyle` to a Map
  Map<String, dynamic> serializeTextStyle(TextStyle style) {
    return {
      'color': style.color?.value,
      'fontSize': style.fontSize,
      'fontWeight': style.fontWeight?.toString(),
    };
  }

  /// Deserialize `TextStyle` from a Map
  TextStyle deserializeTextStyle(Map<String, dynamic> map) {
    return TextStyle(
      color: map['color'] != null ? Color(map['color']) : null,
      fontSize: map['fontSize'],
      fontWeight: map['fontWeight'] != null
          ? FontWeight.values.firstWhere(
              (e) => e.toString() == map['fontWeight'],
              orElse: () => FontWeight.normal,
            )
          : null,
    );
  }
}
