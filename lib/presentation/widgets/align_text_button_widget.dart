import '../cubit/status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlignTextButtonsWidget extends StatelessWidget {
  const AlignTextButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            BlocProvider.of<StatusCubit>(context).changeTextAlign(
                align: TextAlign.left, textDirection: TextDirection.ltr);
          },
          icon: Icon(Icons.align_horizontal_left),
        ),
        IconButton(
          onPressed: () {
            BlocProvider.of<StatusCubit>(context).changeTextAlign(
                align: TextAlign.center, textDirection: TextDirection.ltr);
          },
          icon: Icon(Icons.align_horizontal_center),
        ),
        IconButton(
          onPressed: () {
            BlocProvider.of<StatusCubit>(context).changeTextAlign(
                align: TextAlign.right, textDirection: TextDirection.rtl);
          },
          icon: Icon(Icons.align_horizontal_right),
        ),
      ],
    );
  }
}
