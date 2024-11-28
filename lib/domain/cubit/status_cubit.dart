import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/status_text_model.dart';
import '../../data/services/cache_status_data.dart';
part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit() : super(StatusInitial());
  TextEditingController controller = TextEditingController();

  double fontSize = 16.0;
  Color fillColor = Colors.white;
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

  Future<void> saveLoaclTextStatus() async {
    final statusTextModel = StatusTextModel(
        text: controller.text,
        fillColor: fillColor,
        textAlign: textAlign,
        textDirection: textDirection,
        textStyle: currentTextStyle);

    await LoacalStatusData.saveData(statusTextModel);
    emit(SaveLocalStatusState(message: "Data saved successfully"));
  }

  void loadLoaclTextStatus() async {
    final statusTextModel = await LoacalStatusData.loadData();
    if (statusTextModel != null) {
      controller.text = statusTextModel.text;
      fillColor = statusTextModel.fillColor;
      textAlign = statusTextModel.textAlign;
      textDirection = statusTextModel.textDirection;
      currentTextStyle = statusTextModel.textStyle;
      fontSize = statusTextModel.textStyle.fontSize ?? 16.0;
      emit(LoadLocalStatusState(message: "Data Loaded successfully"));
    }
  }
}
