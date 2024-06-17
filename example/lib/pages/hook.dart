import 'package:flutter/material.dart';
import 'package:example/global.dart';

class HookDemoPage extends HookWidget {
  const HookDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook测试页面'),
      ),
      body: SingleChildScrollView(
        child: ColumnWidget(children: [
          useButton(_useStateData()),
          TapBuilder(
            onTap: () {},
            delay: 0,
            builder: (isTap) => Container(
              width: 100,
              height: 100,
              color: Colors.grey.onTap(isTap),
            ),
          ),
          const Gap(16),
          TapBuilder(
            onTap: () {},
            delay: 0,
            builder: (isTap) => AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 100,
              height: 100,
              color: isTap ? Colors.green : Colors.grey,
            ),
          ),
          const Gap(16),
          TapBuilder(
            onTap: () {},
            delay: 500,
            builder: (isTap) => AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 100,
              height: 100,
              color: isTap ? Colors.green : Colors.grey,
            ),
          ),
          const Gap(16),
          TapBuilder(
            onTap: () {},
            delay: 1000,
            builder: (isTap) => AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 100,
              height: 100,
              color: isTap ? Colors.green : Colors.grey,
            ),
          ),
          const Gap(16),
          SelectionArea(
            child: TapBuilder(
              onTap: () {},
              delay: 300,
              builder: (isTap) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 100,
                height: 100,
                color: isTap ? Colors.green : Colors.grey,
              ),
            ),
          ),
          const H1('一级Title'),
          const H2('二级Title'),
          const H3('三级Title'),
          const H4('四级Title'),
          const H5('五级Title'),
          const H6('六级Title'),
          const P('普通文本'),
          const A('https://www.baidu.com'),
          const P(['这是一段文字，里面包含', B('加粗'), '、', I('斜体'), '、', '文字']),
          const P([
            '富文本',
            P('红色文本', color: Colors.red),
            Icon(Icons.home),
            H1('一级Title'),
            H1('一级Title', color: Colors.purple),
            H2([
              Text('二级标题'),
              Text(
                '二级标题',
                style: TextStyle(color: Colors.green),
              ),
            ]),
          ]),
        ]),
      ),
    );
  }
}

Widget useButton(HookRecoard hook) {
  useEffect(() {
    i(hook.count.value);
    // if (count.value > 30) {
    //   return count.dispose;
    // } else {
    //   return null;
    // }
    return null;
  }, [hook.count.value]);

  return Column(
    children: [
      Text('${hook.count.value * 2}'),
      ElevatedButton(
        onPressed: () => hook.addCount(),
        child: Text('count: ${hook.count.value}'),
      ),
    ],
  );
}

typedef HookRecoard = ({
  ValueNotifier<int> count,
  void Function() addCount,
});

HookRecoard _useStateData() {
  final count = useState(0);

  void addCount() {
    count.value++;
  }

  return (count: count, addCount: addCount);
}
