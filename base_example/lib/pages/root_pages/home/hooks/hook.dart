import 'package:base_example/global.dart';
import 'package:base_example/pages/root_pages/home/hooks/base.dart';
import 'package:base_example/pages/root_pages/home/hooks/getx.dart';
import 'package:base_example/pages/root_pages/home/hooks/input.dart';
import 'package:base_example/pages/root_pages/home/hooks/ui_data.dart';
import 'package:flutter/material.dart';

class HookPage extends HookWidget {
  const HookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              buildListTileWidget(context, title: '基础hook示例', page: const BaseHookPage()),
              buildListTileWidget(context, title: 'Getx控制器hook', page: const GetxHookPage()),
              buildListTileWidget(context, title: 'Input双向绑定示例', page: const InputHookePage()),
              buildListTileWidget(context, title: 'UiDataHookPage', page: const UiDataHookPage()),
            ],
          ),
        ),
      ),
    );
  }
}
