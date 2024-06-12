import 'package:flutter/material.dart';
import 'package:example/global.dart';

class ComponentDecoration extends StatelessWidget {
  const ComponentDecoration(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontUtil.bold,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
              child: Column(children: children),
            ),
          ),
        ),
      ],
    );
  }
}

class RowCell extends StatelessWidget {
  const RowCell({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children,
      ),
    );
  }
}
