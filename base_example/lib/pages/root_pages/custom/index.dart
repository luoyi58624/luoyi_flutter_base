import 'package:flutter/material.dart';

class CustomRootPage extends StatefulWidget {
  const CustomRootPage({super.key});

  @override
  State<CustomRootPage> createState() => _CustomRootPageState();
}

class _CustomRootPageState extends State<CustomRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Components'),
      ),
      body: Container(),
    );
  }
}
