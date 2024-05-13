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
          style: TextStyle(fontFamily: context.appConfig.fontFamily),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  '基础组件',
                  style: context.h4,
                ),
              ),
              Column(
                children: [
                  buildListTileWidget(
                    context,
                    title: 'Button 按钮',
                    onTap: () {},
                  ),
                  buildListTileWidget(
                    context,
                    title: 'Switch 开关',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
