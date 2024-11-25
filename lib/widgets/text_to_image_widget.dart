import 'dart:developer';
import 'dart:ui' as ui;
import 'package:creative_status/helper/contstants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:creative_status/cubit/status_cubit.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../helper/widgets/snackbar_widget.dart';

class TextToImageWidget extends StatefulWidget {
  const TextToImageWidget({
    super.key,
  });

  @override
  State<TextToImageWidget> createState() => _TextToImageWidgetState();
}

class _TextToImageWidgetState extends State<TextToImageWidget> {
  GlobalKey _globalKey = GlobalKey();

  File? file;
  bool _loading = false;
  late final StatusCubit statusCubit;
  @override
  void initState() {
    statusCubit = BlocProvider.of<StatusCubit>(context);

    super.initState();
  }

  void shareImage() async {
    await _convertTextToImage();
    await statusCubit.saveLoaclTextStatus();
    Share.shareXFiles([XFile('${file!.path}')], text: null);
  }

  Future<void> _convertTextToImage() async {
    try {
      setState(() {
        _loading = true;
      });
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/text_image.png';
        file = File(filePath);
        await file!.writeAsBytes(byteData.buffer.asUint8List());
        setState(() {
          _loading = false;
        });

        showToastification(
            message: 'Image is saved to share', context: context);
      }
    } catch (e) {
      print('Error: $e');
      showToastification(
        message: 'Failed to save image',
        state: AlertState.error,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocListener<StatusCubit, StatusState>(
        listener: (context, state) {
          if (state is SaveLocalStatusState) {
            log(state.message);
            showToastification(message: state.message, context: context);
          }
        },
        child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RepaintBoundary(
                        key: _globalKey,
                        child: Container(
                          color: statusCubit.fillColor,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            statusCubit.controller.text,
                            textAlign: statusCubit.textAlign,
                            textDirection: statusCubit.textDirection,
                            style: statusCubit.currentTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          shareImage();
                        },
                        child: _loading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: MyColors.primary,
                                ),
                              )
                            : Text('Share Image'),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
