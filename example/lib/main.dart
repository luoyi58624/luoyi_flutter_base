import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Center(
          child: Column(
            children: [
              DefaultTextStyle(
                style: TextStyle(color: Colors.grey),
                child: H1(
                  ['一级标题 (H1)', H4('四级标题')],
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              // const H2('二级标题 (H2)'),
              // const H3('三级标题 (H3)'),
              // const H4('四级标题 (H4)'),
              // const H5('五级标题 (H5)'),
              // const H6('六级标题 (H6)'),
            ],
          ),
        ),
      ),
    );
  }
}
