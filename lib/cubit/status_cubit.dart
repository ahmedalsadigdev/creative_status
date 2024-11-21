import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit() : super(StatusInitial());

  double fontSize = 16.0;
  Color fillColor = Colors.transparent;
  TextAlign textAlign = TextAlign.left;
  TextDirection textDirection = TextDirection.ltr;

  TextStyle currentTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  void changeTextColor(Color color) {
    currentTextStyle = currentTextStyle.copyWith(color: color);
    emit(UpdateStatusState(currentTextStyle: currentTextStyle));
  }

  void changeTextAlign(
      {required TextAlign align, required TextDirection textDirection}) {
    textAlign = align;
    this.textDirection = textDirection;
    emit(ChangeTextAlignState(
        textAlign: this.textAlign, direction: this.textDirection));
  }

  void changeFieldBackgroundColor(Color color) {
    fillColor = color;
    emit(UpdateFieldBackgroundState(color: fillColor));
  }

  void changeFontSize(String sign) {
    sign == "+" ? fontSize += 3.0 : fontSize -= 3.0;
    if (fontSize <= 6) return;
    currentTextStyle = currentTextStyle.copyWith(fontSize: fontSize);
    emit(UpdateStatusState(currentTextStyle: currentTextStyle));
  }

  void toggleFontWeight() {
    currentTextStyle = currentTextStyle.copyWith(
      fontWeight: currentTextStyle.fontWeight == FontWeight.bold
          ? FontWeight.normal
          : FontWeight.bold,
    );
    emit(UpdateStatusState(currentTextStyle: currentTextStyle));
  }
}
