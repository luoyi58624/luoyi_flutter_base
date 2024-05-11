import 'package:flutter/material.dart';

import '../../../global.dart';

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
        title: Text(
          S.of(context).appbarLabelMaterial,
          style: TextStyle(fontFamily: context.configData.fontFamily),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    '基础组件',
                    style: context.h4,
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: const Text('Button 按钮', style: TextStyle(fontSize: 15)),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: const Text('Switch 开关', style: TextStyle(fontSize: 15)),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
