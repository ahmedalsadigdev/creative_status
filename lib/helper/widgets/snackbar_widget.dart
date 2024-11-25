import 'package:creative_status/helper/contstants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

enum AlertState {
  success,
  error,
  info,
}

void showSnackBarWidget(
    {required BuildContext context,
    required String message,
    AlertState state = AlertState.success}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white), // Custom text color
    ),
    backgroundColor: AlertStateColor(state), // Change background color
    behavior:
        SnackBarBehavior.floating, // Makes it appear as a floating snackbar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Add rounded corners
    ),
  ));
}

void showToastWidget(
    {required String message,
    AlertState state = AlertState.success,
    Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AlertStateColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

void showToastification({
  required BuildContext context,
  required String message,
  AlertState state = AlertState.success,
}) {
  toastification.show(
    context: context, // optional if you use ToastificationWrapper
    title: Text(message),
    icon: AlertStateIcon(state),
    showIcon: true, // show or hide the icon
    primaryColor: AlertStateColor(state),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
    autoCloseDuration: const Duration(seconds: 5),
  );
}

Color AlertStateColor(AlertState state) {
  switch (state) {
    case AlertState.success:
      return Colors.green;
    case AlertState.error:
      return MyColors.buttonColor;
    case AlertState.info:
      return MyColors.secondary;
    default:
      return MyColors.primary;
  }
}

Widget AlertStateIcon(AlertState state) {
  switch (state) {
    case AlertState.success:
      return const Icon(Icons.check);
    case AlertState.error:
      return const Icon(Icons.cancel_outlined);
    case AlertState.info:
      return const Icon(Icons.info_outline);
    default:
      return const Icon(Icons.check);
  }
}
