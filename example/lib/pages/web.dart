import 'package:example/global.dart';
import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Body([
        'hello',
        'hello',
        Icon(Icons.cabin),
        Div2('xxx'),
        Div2('xxx'),
        Div2('xxx'),
        Div2('xxx'),
      ]),
    );
  }
}
