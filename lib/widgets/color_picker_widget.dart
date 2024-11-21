import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  final Function(Color)
      changeColor; // Function type that takes a Color parameter
  final String ButtonText;

  final Icon icon;

  const ColorPickerWidget(
      {super.key,
      required this.changeColor,
      required this.ButtonText,
      required this.icon});

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.icon,
      onPressed: () => _pickColor(),
    );
  }

  void _pickColor() {
    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          // child: ColorPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          // ),

          // Use Material color picker:
          //
          child: MaterialPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,

            enableLabel: true, // only on portrait mode
          ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
          //
          // child: MultipleChoiceBlockPicker(
          //   pickerColors: currentColors,
          //   onColorsChanged: changeColors,
          // ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Defualt Color'),
            onPressed: () {
              widget.changeColor(widget.ButtonText == "Background Color"
                  ? Colors.transparent
                  : Colors.black87); // Call the function with Color
              Navigator.pop(context); // Close the dialog
            },
          ),
          ElevatedButton(
            child: const Text('Select'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              widget.changeColor(currentColor); // Call the function with Color
              Navigator.pop(context); // Close the dialog
            },
          ),
        ],
      ),
      context: context,
    );
  }
}
