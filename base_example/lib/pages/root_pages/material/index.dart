import 'package:flutter/material.dart';

class MaterialRootPage extends StatefulWidget {
  const MaterialRootPage({super.key});

  @override
  State<MaterialRootPage> createState() => _MaterialRootPageState();
}

class _MaterialRootPageState extends State<MaterialRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Components'),
      ),
      body: Container(),
    );
  }
}
