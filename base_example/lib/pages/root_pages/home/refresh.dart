import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class RefreshPage extends HookWidget {
  const RefreshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('下拉刷新'),
      ),
      body: EasyRefresh(
        onRefresh: ()async{
          await 2.delay();
        },
        header: const MaterialHeader(),
        child: buildListViewDemo(itemCount: 100),
      )
    );
  }
}
