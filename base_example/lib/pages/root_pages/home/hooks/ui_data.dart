import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

/// 返回 Record 类型
(ValueNotifier<int>, void Function()) _useData1() {
  final count = useState(0);

  void addCount() {
    count.value++;
  }

  return (count, addCount);
}

/// 指定命名
({ValueNotifier<int> count2, void Function() addCount2}) _useData2() {
  final count = useState(0);

  void addCount() {
    count.value++;
  }

  return (count2: count, addCount2: addCount);
}

/// 响应式变量私有化
({int count, void Function() addCount}) _useData3() {
  final count = useState(0);

  void addCount() {
    count.value++;
  }

  /// count返回.value，可以防止外部修改响应式变量
  return (count: count.value, addCount: addCount);
}

class UiDataHookPage extends HookWidget {
  const UiDataHookPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 默认 Record 只能通过$1、$2来获取参数
    final data1 = _useData1();

    // 推荐以解构方式赋值
    final (count1, addCount1) = _useData1();

    // 命名 Record 可以通过传统对象的方式获取参数
    final data2 = _useData2();

    // 解构命名 Record 需要在前面指定冒号:
    // 说实话感觉不怎么优雅
    final (:count2, :addCount2) = _useData2();

    final data3 = _useData3();

    useEffect(() {
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UI和Data分离示例'),
      ),
      body: buildCenterColumn([
        ElevatedButton(
          onPressed: () {
            data1.$2();
          },
          child: Text('count1: ${data1.$1.value}'),
        ),
        ElevatedButton(
          onPressed: () {
            addCount1();
          },
          child: Text('count1: ${count1.value}'),
        ),
        ElevatedButton(
          onPressed: () {
            addCount2();
          },
          child: Text('count2: ${count2.value}'),
        ),
        ElevatedButton(
          onPressed: () {
            data2.addCount2();
          },
          child: Text('count2: ${data2.count2.value}'),
        ),
        ElevatedButton(
          onPressed: () {
            data3.addCount();
          },
          child: Text('count3: ${data3.count}'),
        ),
      ]),
    );
  }
}
