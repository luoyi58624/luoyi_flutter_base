import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:web/web.dart' as web;

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
              SelectableText(web.window.navigator.userAgent),
              Text(web.window.navigator.userAgent.contains('Macintosh').toString()),
              Text('IOS: ${PlatformUtil.isIOS}'),
            ],
          ),
        ),
      ),
    );
  }
}
