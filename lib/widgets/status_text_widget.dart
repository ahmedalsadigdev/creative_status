import 'dart:developer';

import 'package:creative_status/cubit/status_cubit.dart';
import 'package:creative_status/helper/contstants/my_colors.dart';
import 'package:creative_status/widgets/color_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'align_button_widget.dart';

class StatusTextWidget extends StatefulWidget {
  StatusTextWidget({
    super.key,
  });

  @override
  State<StatusTextWidget> createState() => _StatusTextWidgetState();
}

class _StatusTextWidgetState extends State<StatusTextWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final statusCubit = BlocProvider.of<StatusCubit>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          settingButtonsWidget(context, statusCubit),
          SizedBox(height: 20),
          buildTextField(statusCubit),
        ],
      ),
    );
  }

  Widget buildTextField(StatusCubit statusCubit) {
    return BlocBuilder<StatusCubit, StatusState>(
      builder: (context, state) {
        return TextField(
          controller: _controller,
          style: statusCubit.currentTextStyle, // Apply dynamic text style
          onChanged: (value) {
            log(value);
          },
          autocorrect: false,
          textAlign: statusCubit.textAlign,
          keyboardType: TextInputType.multiline,
          maxLines: null, // <-- SEE HERE
          decoration: InputDecoration(
              filled: true, // Ensure that the background color is applied
              fillColor: statusCubit.fillColor,
              // labelText: 'What are you thinking?',
              hintText: 'Type here...',
              border: InputBorder.none),
        );
      },
    );
  }

  Widget settingButtonsWidget(BuildContext context, StatusCubit statusCubit) {
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
