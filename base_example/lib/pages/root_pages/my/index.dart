import 'package:flutter/material.dart';

class MyRootPage extends StatefulWidget {
  const MyRootPage({super.key});

  @override
  State<MyRootPage> createState() => _MyRootPageState();
}

class _MyRootPageState extends State<MyRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: Container(),
    );
  }
}
