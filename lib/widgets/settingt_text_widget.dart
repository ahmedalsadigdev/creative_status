import 'dart:developer';

import 'package:creative_status/cubit/status_cubit.dart';
import 'package:creative_status/helper/contstants/my_colors.dart';
import 'package:creative_status/widgets/color_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'align_button_widget.dart';

class SettingTextWidget extends StatelessWidget {
  const SettingTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final statusCubit = BlocProvider.of<StatusCubit>(context);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: MyColors.primary)),
      child: Wrap(
        children: [
          ColorPickerWidget(
            icon: Icon(
              Icons.font_download_outlined,
              color: MyColors.buttonColor,
              size: 30,
            ),
            ButtonText: "Text Color",
            changeColor: (color) {
              BlocProvider.of<StatusCubit>(context).changeTextColor(color);
            },
          ),
          ColorPickerWidget(
            icon: Icon(
              Icons.font_download,
              color: MyColors.buttonColor,
              size: 30,
            ),
            ButtonText: "Background Color",
            changeColor: (color) {
              BlocProvider.of<StatusCubit>(context)
                  .changeFieldBackgroundColor(color);
            },
          ),
          AlignButtonWidget(),
          IconButton(
            onPressed: statusCubit.toggleFontWeight,
            icon: Icon(
              Icons.format_bold,
              color: MyColors.buttonColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () => statusCubit.changeFontSize("+"),
            icon: Icon(
              Icons.text_increase,
              color: MyColors.buttonColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () => statusCubit.changeFontSize("-"),
            icon: Icon(
              Icons.text_decrease,
              color: MyColors.buttonColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
