import 'dart:developer';
import 'package:creative_status/cubit/status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settingt_text_widget.dart';

class StatusTextWidget extends StatefulWidget {
  StatusTextWidget({
    super.key,
  });

  @override
  State<StatusTextWidget> createState() => _StatusTextWidgetState();
}

class _StatusTextWidgetState extends State<StatusTextWidget> {
  @override
  Widget build(BuildContext context) {
    final statusCubit = BlocProvider.of<StatusCubit>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SettingTextWidget(),
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
          controller: statusCubit.controller,
          style: statusCubit.currentTextStyle, // Apply dynamic text style
          onChanged: (value) {},
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
}
