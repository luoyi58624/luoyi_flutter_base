import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Map<dynamic, dynamic> map = {'name': 'luoyi', 'age': 20};
            i(map.runtimeType.toString());
            var map2 = map.cast<String, dynamic>();
            i(map2.runtimeType.toString());
            Map<String, dynamic> user3 = Map.castFrom(map);
            i(user3.runtimeType.toString());
            var user4 = user3 as Map<String, dynamic>;
            i(user4.runtimeType.toString());
            Map<String, dynamic> user5 = Map.from(map);
            i(user5.runtimeType.toString());
          },
          child: const Text('获取变量的真实类型'),
        ),
      ),
    );
  }
}
