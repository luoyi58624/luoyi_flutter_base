import 'package:base_example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

extension ColorPickerExtension on BuildContext {
  Future<Color?> showColorPicker(Color color) async {
    return await showDialog<Color>(
        context: this,
        barrierColor: Colors.black12,
        builder: (context) {
          Color selectedColor = color;
          return UnconstrainedBox(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(6),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: [
                        ColorPicker(
                          pickerColor: selectedColor,
                          portraitOnly: true,
                          colorPickerWidth: 280,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: true,
                          displayThumbColor: true,
                          paletteType: PaletteType.hsvWithHue,
                          pickerAreaBorderRadius: BorderRadius.circular(6),
                          labelTypes: const [],
                          onColorChanged: (Color color) {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text('关闭')),
                            TextButton(
                                onPressed: () {
                                  context.pop(selectedColor);
                                },
                                child: const Text('确定')),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
