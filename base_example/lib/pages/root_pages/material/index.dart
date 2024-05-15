import 'package:flutter/material.dart';

import '../../../global.dart';
import 'base/button.dart';
import 'base/form.dart';
import 'base/refresh.dart';
import 'base/switch.dart';
import 'layout/tab.dart';

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
        title: Text(S.of(context).appbarLabelMaterial),
      ),
      body: buildScrollWidget(
        child: Column(
          children: [
            buildCardWidget(context, title: '基础组件', children: [
              buildCellWidget(context, title: 'Button 按钮', page: const ButtonPage()),
              buildCellWidget(context, title: 'Switch 开关', page: const SwitchPage()),
              buildCellWidget(context, title: 'Form 表单', page: const FormPage()),
              buildCellWidget(context, title: 'Refersh 刷新器', page: const RefreshPage()),
            ]),
            buildCardWidget(context, title: '布局组件', children: [
              buildCellWidget(context, title: 'Tab 标签导航', page: const TabPage()),
            ]),
          ],
        ),
      ),
    );
  }
}
