import '../../domain/cubit/status_cubit.dart';
import '../../helper/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settingt_text_buttons_widget.dart';

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
          SettingTextButtonsWidget(),
          SizedBox(height: 20),
          buildTextField(statusCubit),
        ],
      ),
    );
  }

  /// build main text field
  Widget buildTextField(StatusCubit statusCubit) {
    return BlocConsumer<StatusCubit, StatusState>(
      listener: (BuildContext context, StatusState state) {
        if (state is LoadLocalStatusState) {
          showSnackBarWidget(context: context, message: state.message);
        }
      },
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
