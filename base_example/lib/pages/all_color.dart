import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class AllColorTestPage extends HookWidget {
  const AllColorTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Colors'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: buildBaseColors(context),
            ),
            ...buildMaterialColors(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildBaseColors(BuildContext context) {
    List<Widget> widgets = [
      buildColorWidget(
        name: 'white',
        color: Colors.white,
      ),
      buildColorWidget(
        name: 'black',
        color: Colors.black,
      ),
      buildColorWidget(
        name: 'primary',
        color: context.flutterTheme.primary,
      ),
      buildColorWidget(
        name: 'success',
        color: context.flutterTheme.success,
      ),
      buildColorWidget(
        name: 'warning',
        color: context.flutterTheme.warning,
      ),
      buildColorWidget(
        name: 'error',
        color: context.flutterTheme.error,
      ),
      buildColorWidget(
        name: 'info',
        color: context.flutterTheme.info,
      ),
    ];
    return widgets;
  }

  List<Widget> buildMaterialColors() {
    List<Widget> widgets = [];
    FlutterColorData.materialColors.forEach((k, v) {
      List<Widget> childrenWidgets = [];
      FlutterColorData.materialColorSwatchs.forEach((i) {
        childrenWidgets.add(buildColorWidget(
          name: k,
          color: v[i]!,
          materialSwatchs: i,
        ));
      });
      widgets.add(
        SingleChildScrollView(
          child: Column(
            children: childrenWidgets,
          ),
        ),
      );
    });

    return widgets;
  }

  Widget buildColorWidget({
    required String name,
    required Color color,
    int? materialSwatchs,
  }) {
    return Container(
      width: 100,
      height: 100,
      color: color,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: TextStyle(
                color: color.isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            if (materialSwatchs != null)
              Text(
                '$materialSwatchs',
                style: TextStyle(color: color.isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
              ),
            if (materialSwatchs != null) const SizedBox(height: 2),
            Text(
              color.toHex(hasLeading: true),
              style: TextStyle(color: color.isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              'hsp: ${color.hsp}',
              style: TextStyle(color: color.isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
